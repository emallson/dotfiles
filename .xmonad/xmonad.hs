import XMonad
import System.Exit
import XMonad.Prompt
import qualified XMonad.StackSet as W

import XMonad.Actions.WindowGo (raiseMaybe, runOrRaise)
import XMonad.Actions.WorkspaceNames (renameWorkspace)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP, checkKeymap)

main :: IO ()
main = xmonad $ ewmh defaultConfig
                       {
                         modMask = mod3Mask
                       , terminal = "st -e tmux attach"
                       , focusFollowsMouse = False
                       , clickJustFocuses = False
                       , normalBorderColor = "#202020"
                       , focusedBorderColor = "#404040"
                       }
                       `removeKeysP`
                       [
                         "M-k"
                       , "M-S-k"
                       , "M-j"
                       , "M-S-j"
                       , "M-p"
                       ]
                       `additionalKeysP`
                       [("M-n", windows W.focusDown)
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
                       ,("C-S-q", io (exitSuccess)) -- emergency hatch while debugging mod3Mask
                       ,("M-C-k", spawn "./.xmonad/switch-keymap.sh")
                       ]
