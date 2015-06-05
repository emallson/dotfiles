-- -*- flycheck-mode: nil -*-
import XMonad
import Data.List
import Data.List.Split
import System.Exit
import System.Process
import Network.HostName
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS (toggleOrView)
import XMonad.Actions.WindowGo
import XMonad.Actions.WorkspaceNames (renameWorkspace, workspaceNamesPP, getWorkspaceNames)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Tabbed
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, checkKeymap)
import XMonad.Util.Run

tmuxAttach :: String -> X ()
tmuxAttach session = spawn ("st -e tmux attach -t " ++ session)

tmuxCreateAttach :: String -> X ()
tmuxCreateAttach session = spawn ("st -e tmux new-session -s " ++ session)

tmuxSessionCompl :: String -> IO [String]
tmuxSessionCompl input = do output <- readProcess "tmux" ["list-sessions", "-F", "#{session_name}"] ""
                            return $ filter (isInfixOf input) $ lines output

myXPConfig = defaultXPConfig { showCompletionOnTab = True, autoComplete = Just 1000}

strutsOn locs = sendMessage $ SetStruts locs []
strutsOff locs = sendMessage $ SetStruts [] locs

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myKeymap = [("M-n", windows W.focusDown)
           ,("M-S-n", windows W.swapDown)
           ,("M-e", windows W.focusUp)
           ,("M-S-e", windows W.swapUp)
           ,("M-S-m", windows W.swapMaster)
           ,("M-S-s", sendMessage Expand)
           ,("M-S-t", sendMessage Shrink)
           ,("M-k", kill)
           ,("M-r", spawn "dmenu_run")
           ,("M-b", runOrRaise "chromium-browser" (className =? "Chromium-browser"))
           ,("M-c", raiseMaybe (spawn "st -e tmux attach") (className =? "st-256color"))
           ,("M-S-c", inputPromptWithCompl myXPConfig "Session" tmuxSessionCompl ?+ tmuxAttach)
           ,("M-C-c", inputPrompt myXPConfig "Session" ?+ tmuxCreateAttach)
           ,("M-<Space>", raiseMaybe (spawn "emacsclient -c") (className =? "Emacs"))
           ,("M-C-<Space>", spawn "emacsclient -c")
           ,("M-,", renameWorkspace defaultXPConfig)
           ,("C-S-q", io exitSuccess) -- emergency hatch while debugging mod3Mask
           ,("M-C-k", spawn "./.xmonad/switch-keymap.sh")
           ,("M-S-l", sendMessage ToggleStruts)
           ,("M-S-g", strutsOff [U])
           ,("M-C-S-g", strutsOn [U])
           ,("M-=", sendMessage (IncMasterN 1))
           ,("M--", sendMessage (IncMasterN (-1)))
           ,("M-.", withFocused $ windows . W.sink) -- Push window back into tiling
           ,("M-w", sendMessage NextLayout)
           -- ,("M-S-w", setLayout $ XMonad.layoutHook myConfig)
           ]
           ++
           [(otherModMasks ++ "M-" ++ key, screenWorkspace tag >>= flip whenJust (windows . action))
            | (tag, key) <- zip [0..] ["z", "x"]
            , (otherModMasks, action) <- [("", W.view), ("S-", W.shift)]]
           ++
           [(otherModMasks ++ "M-" ++ key, action tag)
             | (tag, key) <- zip myWorkspaces myWorkspaces
             , (otherModMasks, action) <- [("", toggleOrView)
                                          ,("S-", windows . W.shift)]]

myLayoutHook = avoidStrutsOn [L] $ simpleTabbed ||| layoutHook defaultConfig

myConfig = ewmh defaultConfig {modMask = mod5Mask
                              , terminal = "st -e tmux attach"
                              , focusFollowsMouse = False
                              , clickJustFocuses = False
                              , normalBorderColor = "#202020"
                              , focusedBorderColor = "#404040"
                              , startupHook = return () >> checkKeymap myConfig myKeymap
                              , manageHook = manageHook defaultConfig <+> manageDocks
                              , layoutHook = myLayoutHook
                              }
                              `removeKeysP`
                              ["M-k"
                              , "M-S-k"
                              , "M-j"
                              , "M-S-j"
                              , "M-p"
                              , "M-h"
                              , "M-l"
                              , "<XF86AudioRaiseVolume>"
                              , "<XF86AudioLowerVolume>"
                              , "<XF86AudioMute>"
                              ]
                              `additionalKeysP`
                              myKeymap

emallsonPP :: PP
emallsonPP = defaultPP {ppOrder = \(ws:_:_:_) -> [ws]}

xmobarCmd :: IO String
xmobarCmd = do hostName <- getHostName
               return $ "/home/emallson/.cabal/bin/xmobar /home/emallson/.xmonad/" ++ hostName ++ "/xmobar.hs"

xmb cmdIO pp kfn conf = do
  cmd <- cmdIO
  statusBar cmd pp kfn conf

myToggleStrutsKey XConfig{modMask = modm} = (modm .|. shiftMask, xK_l)

main :: IO ()
main = xmonad =<< (xmb xmobarCmd emallsonPP myToggleStrutsKey myConfig)
