-- -*- flycheck-mode: nil -*-
module Main where

import Control.Monad

import System.Exit
import System.Process

import Network.HostName

import Data.List
import Data.Bool
import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS (toggleOrDoSkip)
import XMonad.Actions.Submap
import XMonad.Actions.WindowGo
import XMonad.Actions.WindowBringer
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.DynamicWorkspaceGroups
import XMonad.Actions.CopyWindow
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.Place
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, checkKeymap, mkKeymap)
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.WorkspaceCompare (getSortByIndex)
import XMonad.Prompt
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- tree layout stuff
import XMonad.Actions.Navigation2D
import XMonad.Layout.BorderResize

-- minimize
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows

qnot :: Monad m => m Bool -> m Bool
qnot = liftM not

tmuxAttach :: String -> X ()
tmuxAttach session = spawn ("st -e tmux attach -t " ++ session)

tmuxCreateAttach :: String -> X ()
tmuxCreateAttach session = spawn ("st -e tmux new-session -s " ++ session)

tmuxSessionCompl :: String -> IO [String]
tmuxSessionCompl input = do output <- runProcessWithInput "tmux" ["list-sessions", "-F", "#{session_name}"] ""
                            return $ filter (isInfixOf input) $ lines output

data Tmux = Tmux

instance XPrompt Tmux where
         showXPrompt Tmux = "Session: "

tmuxCreatePrompt :: XPConfig -> X ()
tmuxCreatePrompt c = do
                 mkXPrompt Tmux c tmuxSessionCompl tmuxCreateAttach

tmuxAttachPrompt :: XPConfig -> X ()
tmuxAttachPrompt c = do
                 mkXPrompt Tmux c tmuxSessionCompl tmuxAttach

myLayoutHook = boringWindows $ minimize $ avoidStruts $ borderResize $ mkToggle (single FULL) (Tall 1 0.03 0.5)

myKeymap = [("M-k", kill1)
           ,("M-r", spawn "dmenu_run")
           ,("M-p", spawn "gnome-screenshot -a")
           ,("C-S-q", io exitSuccess)
           ,("M-S-l", sendMessage ToggleStruts)
           ,("M-l", spawn "i3lock -t -i /home/emallson/Pictures/ravnica.png")
           ,("M-.", switchLayer)
           ,("M-S-.", withFocused $ windows . W.sink)
           ,("M-<Backspace>", sendMessage $ Toggle FULL)
           ,("M-,", renameWorkspace defaultXPConfig)
           ,("M-m", withFocused minimizeWindow)
           ,("M-S-m", sendMessage RestoreNextMinimizedWin)
           -- program binds
           ,("M-S-c", tmuxAttachPrompt defaultXPConfig)
           ,("M-C-c", tmuxCreatePrompt defaultXPConfig)
           ,("M-b", raiseNextMaybe (spawn "firefox") ((className =? "Firefox-esr") <&&> (stringProperty "WM_WINDOW_ROLE" =? "browser")))
           ,("M-C-b", spawn "firefox")
           ,("M-<Space>", selectWorkspace defaultXPConfig)
           ,("M-C-<Space>", addWorkspacePrompt defaultXPConfig)
           ,("M-S-<Space>", withWorkspace defaultXPConfig (windows . W.shift))
           ,("M-S-k", removeEmptyWorkspace)
           ,("M-c", withWorkspace def (windows . copy))
           ,("M-<Delete>", promptWSGroupView defaultXPConfig "Go to Group: ")
           ,("M-C-<Delete>", promptWSGroupAdd defaultXPConfig "Create Group: ")
           ,("M-S-<Delete>", promptWSGroupForget defaultXPConfig "Forget Group: ")
           ,("M-d", submap $ mkKeymap myConfig
             [("a", spawn "mpd-menu.sh album"),
              ("S-a", spawn "mpd-menu.sh artist"),
              ("t", spawn "mpd-menu.sh title"),
              ("c", spawn "mpc clear"),
              ("p", spawn "mpd-play.sh"),
              ("s", spawn "mpc shuffle"),
              ("n", spawn "mpd-next.sh"),
              ("x", spawn "mpc del 0")])
           ,("M-g", promptWSGroupView defaultXPConfig "Go to Group: ")
           ,("<XF86AudioMute>", spawn "amixer -q set Master toggle")
           ,("<XF86AudioLowerVolume>", spawn "amixer -q sset -- Master 2%-")
           ,("<XF86AudioRaiseVolume>", spawn "amixer -q sset -- Master 2%+")
           ,("<XF86Display>", spawn "~/.local/bin/toggle-touchpad.sh")
           -- set st title because apparently -c only adds the new
           -- classname, doesn't remove the old
           ,("M-<Return>", scratchpadSpawnActionCustom "st -t scratchpad -n scratchpad -e tmux attach -t scratch")]
           ++
           [("M-" ++ otherModMasks ++ key, action direction False)
            | (key, direction) <- zip ["n", "e", "s", "t"] [R, L, U, D]
            , (otherModMasks, action) <- [("", windowGo), ("S-", windowSwap)]]
           ++
           [(otherModMasks ++ "M-" ++ key, screenWorkspace tag >>= flip whenJust (windows . action))
            | (tag, key) <- zip [0..] ["z", "x", "/"]
            , (otherModMasks, action) <- [("", W.view), ("S-", W.shift)]]
           ++
           [(otherModMasks ++ "M-" ++ key, action tag)
            | (tag, key) <- let ws = map show [0..9] in zip ws ws
            , (otherModMasks, action) <- [("", toggleOrDoSkip ["NSP"] W.greedyView)
                                         ,("S-", windows . W.shift)]]

myConfig = withNavigation2DConfig defaultNavigation2DConfig $ ewmh defaultConfig { modMask = mod4Mask
                , terminal = "st"
                , focusFollowsMouse = False
                , clickJustFocuses = False
                , normalBorderColor = "#202020"
                , focusedBorderColor = "#405565"
                , borderWidth = 2
                , startupHook = setWMName "LG3D" >> checkKeymap myConfig myKeymap
                , handleEventHook = docksEventHook
                , manageHook = manageHook defaultConfig <+> composeAll
                               [scratchpadManageHook (W.RationalRect 0 0 1 0.3)
                               ,placeHook $ withGaps (18, 18, 18, 18) $ smart (1, 1)
                               ,(className =? "chromium" <||> className =? "Chromium-browser") <&&> stringProperty "WM_WINDOW_ROLE" =? "pop-up" --> doFloat
                               ,className =? "Pidgin" --> doFloat
                               ,className =? "feh" --> doFloat
                               ,manageDocks]
                , layoutHook = myLayoutHook}
                `removeKeysP`
                ["M-k"
                ,"M-S-k"
                ,"M-j"
                ,"M-S-j"
                ,"M-h"
                ,"M-l"
                ,"<XF86AudioRaiseVolume>"
                ,"<XF86AudioLowerVolume>"
                ,"<XF86AudioMute>"]
                `additionalKeysP`
                myKeymap

emallsonPP :: PP
emallsonPP = defaultPP {ppOrder = \(ws:_:_:_) -> [ws]}

xmobarCmd :: IO String
xmobarCmd = do hostName <- getHostName
               return $ "xmobar /home/emallson/.xmonad/" ++ hostName ++ "/xmobar.hs"

pipeLog :: IO String -> PP -> XConfig l -> IO (XConfig l)
pipeLog cmdIO pp conf = do
    cmd <- cmdIO
    pipe <- spawnPipe cmd
    return $ conf
           {logHook = do
               dynamicLogWithPP (pp {ppOutput = hPutStrLn pipe
                                    ,ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByIndex })}

-- main :: IO ()
main = xmonad =<< pipeLog xmobarCmd emallsonPP myConfig
