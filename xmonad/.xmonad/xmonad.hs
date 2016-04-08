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
import XMonad.Actions.WorkspaceNames
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
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

myKeymap = [("M-k", kill)
           ,("M-r", spawn "dmenu_run")
           ,("C-S-q", io exitSuccess)
           ,("M-S-l", sendMessage ToggleStruts)
           ,("M-l", spawn "i3lock")
           ,("M-.", switchLayer)
           ,("M-S-.", withFocused $ windows . W.sink)
           ,("M-<Backspace>", sendMessage $ Toggle FULL)
           ,("M-,", renameWorkspace defaultXPConfig)
           ,("M-m", withFocused minimizeWindow)
           ,("M-S-m", sendMessage RestoreNextMinimizedWin)
           -- program binds
           ,("M-c", raiseNextMaybe (spawn "st -e tmux attach") ((className =? "st-256color") <&&> (qnot $ title =? "scratchpad")))
           ,("M-S-c", tmuxAttachPrompt defaultXPConfig)
           ,("M-C-c", tmuxCreatePrompt defaultXPConfig)
           ,("M-b", raiseNextMaybe (spawn "chromium") (stringProperty "WM_WINDOW_ROLE" =? "browser"))
           ,("M-C-b", spawn "chromium")
           ,("M-<Space>", raiseNextMaybe (spawn "emacsclient -c") (className =? "Emacs"))
           ,("M-C-<Space>", spawn "emacsclient -c")
           ,("M-d", submap $ mkKeymap myConfig
             [("a", spawn "mpd-menu.sh album"),
              ("S-a", spawn "mpd-menu.sh artist"),
              ("t", spawn "mpd-menu.sh title"),
              ("c", spawn "mpc clear")])
           -- set st title because apparently -c only adds the new
           -- classname, doesn't remove the old
           ,("M-<Return>", scratchpadSpawnActionCustom "st -t scratchpad -c scratchpad -e tmux attach -t scratch")]
           ++
           [("M-" ++ otherModMasks ++ key, action direction False)
            | (key, direction) <- zip ["n", "e", "s", "t"] [R, L, U, D]
            , (otherModMasks, action) <- [("", windowGo), ("S-", windowSwap)]]
           ++
           [(otherModMasks ++ "M-" ++ key, screenWorkspace tag >>= flip whenJust (windows . action))
            | (tag, key) <- zip [0..] ["z", "x"]
            , (otherModMasks, action) <- [("", W.view), ("S-", W.shift)]]
           ++
           [(otherModMasks ++ "M-" ++ key, action tag)
            | (tag, key) <- let ws = map show [0..9] in zip ws ws
            , (otherModMasks, action) <- [("", toggleOrDoSkip ["NSP"] W.view)
                                         ,("S-", windows . W.shift)]]

myConfig = withNavigation2DConfig defaultNavigation2DConfig $ ewmh defaultConfig { modMask = mod4Mask
                , terminal = "st"
                , focusFollowsMouse = False
                , clickJustFocuses = False
                , normalBorderColor = "#202020"
                , focusedBorderColor = "#404040"
                , borderWidth = 1
                , startupHook = setWMName "LG3D" >> checkKeymap myConfig myKeymap
                , handleEventHook = docksEventHook
                , manageHook = manageHook defaultConfig <+> composeAll
                               [scratchpadManageHook (W.RationalRect 0 0 1 0.3)
                               ,className =? "chromium" <&&> stringProperty "WM_WINDOW_ROLE" =? "pop-up" --> doFloat
                               ,manageDocks]
                , layoutHook = myLayoutHook}
                `removeKeysP`
                ["M-k"
                ,"M-S-k"
                ,"M-j"
                ,"M-S-j"
                ,"M-p"
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
                         dynamicLogWithPP =<< workspaceNamesPP (pp {ppOutput = hPutStrLn pipe
                                                                   ,ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByIndex })}

-- main :: IO ()
main = xmonad =<< pipeLog xmobarCmd emallsonPP myConfig
