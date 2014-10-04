import XMonad
import System.Exit
import XMonad.Prompt
import qualified XMonad.StackSet as W

import XMonad.Actions.WindowGo (raiseMaybe, runOrRaise)
import XMonad.Actions.WorkspaceNames (renameWorkspace, workspaceNamesPP)
import XMonad.Layout.LayoutModifier
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, checkKeymap)
import XMonad.Util.Run

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myKeymap = [("M-n", windows W.focusDown)
           ,("M-S-n", windows W.swapDown)
           ,("M-p", windows W.focusUp)
           ,("M-S-p", windows W.swapUp)
           ,("M-S-m", windows W.swapMaster)
           ,("M-k", kill)
           ,("M-r", spawn "dmenu_run")
           ,("M-b", runOrRaise "firefox" (className =? "Firefox"))
           ,("M-c", raiseMaybe (spawn "st -e tmux attach") (className =? "st-256color"))
           ,("M-e", raiseMaybe (spawn "emacsclient -c") (className =? "Emacs"))
           ,("M-,", renameWorkspace defaultXPConfig)
           ,("C-S-q", io exitSuccess) -- emergency hatch while debugging mod3Mask
           ,("M-C-k", spawn "./.xmonad/switch-keymap.sh")
           ,("M-S-l", sendMessage ToggleStruts)
           ]
           ++
           [(otherModMasks ++ "M-" ++ key, screenWorkspace tag >>= flip whenJust (windows . action))
            | (tag, key) <- zip [0..] ["z", "x"]
            , (otherModMasks, action) <- [("", W.view), ("S-", W.shift)]]
           ++
           [(otherModMasks ++ "M-" ++ key, action tag)
             | (tag, key) <- zip myWorkspaces myWorkspaces
             , (otherModMasks, action) <- [("", windows . W.view)
                                          ,("S-", windows . W.shift)]]

myConfig = ewmh defaultConfig {modMask = mod3Mask
                              , terminal = "st -e tmux attach"
                              , focusFollowsMouse = False
                              , clickJustFocuses = False
                              , normalBorderColor = "#202020"
                              , focusedBorderColor = "#404040"
                              , startupHook = return () >> checkKeymap myConfig myKeymap
                              , manageHook = manageHook defaultConfig <+> manageDocks
                              , layoutHook = avoidStruts (layoutHook defaultConfig)
                              }
                              `removeKeysP`
                              ["M-k"
                              , "M-S-k"
                              , "M-j"
                              , "M-S-j"
                              , "M-p"
                              ]
                              `additionalKeysP`
                              myKeymap

emallsonPP :: PP
emallsonPP = defaultPP {ppOrder = \(ws:_:_:_) -> [ws]}

xmobarCmd :: String
xmobarCmd = "xmobar ~/.xmonad/xmobar.hs"

pipeLog :: String -> PP -> XConfig l -> IO (XConfig l)
pipeLog cmd pp conf = do
    pipe <- spawnPipe cmd
    return $ conf
           {logHook = do
                         logHook conf
                         dynamicLogWithPP =<< workspaceNamesPP (pp {ppOutput = hPutStrLn pipe})}

main :: IO ()
main = xmonad =<< pipeLog xmobarCmd emallsonPP myConfig
