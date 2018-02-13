{-# LANGUAGE FlexibleContexts #-}
--- vim:set nolist et tw=0 ts=4 sw=4 sts=4:
import XMonad
import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.WindowNavigation
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Config.Xfce
import XMonad.Actions.CycleWS(nextWS, prevWS)

import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import Data.Monoid (All (All))

import UrgencyHooks
import MyLayouts(myLayout)

import qualified Data.Map as Map

myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "Gimp-2.6" --> doFloat
    , className =? "MPlayer" --> doFloat
    , className =? "Steam" --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "mplayer2" --> doFloat
    , className =? "mpv" --> doFloat
    , className =? "qemu" --> doCenterFloat
    , className =? "xfce4-notifyd" --> doIgnore
    ]

main = do
    xmobar <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook GTKUrgencyHook $ xfceConfig
        { manageHook = manageDocks <+> myManageHook
                       <+> manageHook defaultConfig
        , layoutHook = myLayout
        -- Add xmobar hook, while keeping the xfce hook as well
        , logHook = myLogHook xmobar <+> logHook xfceConfig
        -- , handleEventHook = fullscreenEventHook
        , keys = \c -> myKeys `Map.union` keys defaultConfig c
        -- , terminal = "gnome-terminal"
        , terminal = "xfce4-terminal"
        , borderWidth = 1
        , normalBorderColor = "#cccccc"
        , focusedBorderColor = "#cd8b00" }

myKeys = Map.fromList $ [
    ((mod1Mask, xK_p), spawn "/home/gregdarke/bin/dmenu_run -fn '-*-*-medium-r-*-*-24-*'")
    , ((mod1Mask .|. shiftMask, xK_p), spawn "/usr/bin/xfce4-screenshooter --fullscreen")

    -- Make it easier to move windows around within a workspace.
    , ((mod1Mask .|. controlMask .|. shiftMask, xK_Right), sendMessage $ Move R)
    , ((mod1Mask .|. controlMask .|. shiftMask, xK_Left ), sendMessage $ Move L)
    , ((mod1Mask .|. controlMask .|. shiftMask, xK_Up   ), sendMessage $ Move U)
    , ((mod1Mask .|. controlMask .|. shiftMask, xK_Down ), sendMessage $ Move D)

    -- Make it easier to move between workspaces
    -- (ctrl-alt+{left,right} changes the active workspace
    -- by {+,-}1).
    , ((mod1Mask .|. controlMask, xK_Left  ), prevWS)
    , ((mod1Mask .|. controlMask, xK_Right ), nextWS)
    ]

-- Statusbar pretty printer
myLogHook h = dynamicLogWithPP $ xmobarPP
    { ppOutput = hPutStrLn h
    , ppTitle = xmobarColor "green" "" . shorten 150
    }

-- Helper functions to fullscreen the window
fullFloat, tileWin :: Window -> X ()
fullFloat w = windows $ W.float w r
    where r = W.RationalRect 0 0 1 1
tileWin w = windows $ W.sink w

