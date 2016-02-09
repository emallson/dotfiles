-- -*- flycheck-mode: nil -*-
module Main where

import System.Exit
import System.Process

import Network.HostName

import Data.List

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS (toggleOrDoSkip)
import XMonad.Actions.WindowGo
import XMonad.Actions.WorkspaceNames
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, checkKeymap)
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.WorkspaceCompare (getSortByIndex)
import XMonad.Prompt
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- tree layout stuff
import XMonad.Layout.BinarySpacePartition
import XMonad.Actions.Navigation2D
import XMonad.Layout.BorderResize

-- minimize
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows

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

myLayoutHook = boringWindows $ minimize $ avoidStruts $ borderResize $ mkToggle (single FULL) emptyBSP

myKeymap = [("M-C-n", sendMessage $ ExpandTowards R)
           ,("M-C-e", sendMessage $ ExpandTowards L)
           ,("M-C-s", sendMessage $ ExpandTowards U)
           ,("M-C-t", sendMessage $ ExpandTowards D)
           ,("M-M1-n", sendMessage $ ShrinkFrom R)
           ,("M-M1-e", sendMessage $ ShrinkFrom L)
           ,("M-M1-s", sendMessage $ ShrinkFrom U)
           ,("M-M1-t", sendMessage $ ShrinkFrom D)
           ,("M-k", kill)
           ,("M-r", spawn "dmenu_run")
           ,("C-S-q", io exitSuccess)
           ,("M-S-p", sendMessage FocusParent)
           ,("M-v", sendMessage SelectNode)
           ,("M-S-v", sendMessage MoveNode)
           ,("M-w", sendMessage Rotate)
           ,("M-a", sendMessage Balance)
           ,("M-S-a", sendMessage Equalize)
           ,("M-S-l", sendMessage ToggleStruts)
           ,("M-l", spawn "i3lock")
           ,("M-.", switchLayer)
           ,("M-S-.", withFocused $ windows . W.sink)
           ,("M-<Backspace>", sendMessage $ Toggle FULL)
           ,("M-,", renameWorkspace defaultXPConfig)
           ,("M-m", withFocused minimizeWindow)
           ,("M-S-m", sendMessage RestoreNextMinimizedWin)
           -- program binds
           ,("M-c", raiseNextMaybe (spawn "st -e tmux attach") (className =? "st-256color"))
           ,("M-S-c", tmuxAttachPrompt def)
           ,("M-C-c", tmuxCreatePrompt def)
           ,("M-b", raiseNextMaybe (spawn "chromium") (className =? "chromium"))
           ,("M-C-b", spawn "chromium")
           ,("M-<Space>", raiseNextMaybe (spawn "emacsclient -c") (className =? "Emacs"))
           ,("M-C-<Space>", spawn "emacsclient -c")
           ,("M-<Return>", scratchpadSpawnActionCustom "st -c scratchpad -e tmux attach -t scratch")]
           ++
           [(otherModMasks ++ "M-" ++ key, screenWorkspace tag >>= flip whenJust (windows . action))
            | (tag, key) <- zip [0..] ["z", "x"]
            , (otherModMasks, action) <- [("", W.view), ("S-", W.shift)]]
           ++
           [(otherModMasks ++ "M-" ++ key, action tag)
            | (tag, key) <- let ws = map show [0..9] in zip ws ws
            , (otherModMasks, action) <- [("", toggleOrDoSkip ["NSP"] W.view)
                                         ,("S-", windows . W.shift)]]

myConfig = ewmh def { modMask = mod4Mask
                , terminal = "st"
                , focusFollowsMouse = False
                , clickJustFocuses = False
                , normalBorderColor = "#202020"
                , focusedBorderColor = "#404040"
                , startupHook = setWMName "LG3D" >> checkKeymap myConfig myKeymap
                , handleEventHook = docksEventHook
                , manageHook = manageHook def <+> composeAll
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
emallsonPP = def {ppOrder = \(ws:_:_:_) -> [ws]}

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

main :: IO ()
main = xmonad =<< pipeLog xmobarCmd emallsonPP (navigation2DP
                                                def
                                                ("s", "e", "t", "n")
                                                [("M-", windowGo)
                                                ,("M-S-", windowSwap)]
                                                False
                                                myConfig)
