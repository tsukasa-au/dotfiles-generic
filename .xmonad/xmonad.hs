--- vim:set nolist noet tw=0 ts=4 sw=4 sts=4:
import XMonad
import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)

import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import Data.Monoid (All (All))
import Monad

import UrgencyHooks

import qualified Data.Map as Map

myManageHook = composeAll
	[ className =? "Gimp" --> doFloat
	, className =? "Gimp-2.6" --> doFloat
	, className =? "Vncviewer" --> doFloat
	, className =? "MPlayer" --> doFloat
	, className =? "mplayer2" --> doFloat
	, className =? "Steam" --> doFloat
	]

main = do
	xmobar <- spawnPipe "xmobar"
	xmonad $ withUrgencyHook GTKUrgencyHook $ defaultConfig
		{ manageHook = manageDocks <+> myManageHook
					   <+> manageHook defaultConfig
		-- , layoutHook = avoidStruts $ layoutHints (layoutHook defaultConfig)
		, layoutHook = myLayout
		-- , logHook = dynamicLogWithPP $ myDzenPP dzentop
		, logHook = myLogHook xmobar
		-- , handleEventHook = fullscreenEventHook
		--, handleEventHook = evHook
		, keys = \c -> myKeys `Map.union` keys defaultConfig c
		, terminal = "gnome-terminal"
		, borderWidth = 2
		, normalBorderColor = "#cccccc"
		, focusedBorderColor = "#cd8b00" }

myLayout = avoidStruts $ smartBorders $ layoutHints $ tiled ||| Mirror tiled ||| Full
	where
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = toRational (2/(1+sqrt(5)::Double))
		delta = 3/100

myKeys = Map.fromList $ [
	((mod4Mask .|. shiftMask, xK_q), spawn "gnome-session-save --logout-dialog")
	, ((mod1Mask .|. shiftMask, xK_q), spawn "gnome-session-save --logout-dialog")
	--- , ((mod1Mask .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
	, ((mod1Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command --lock")
	, ((mod1Mask, xK_p), spawn "$HOME/bin/dmenu_run")
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

evHook :: Event -> X All
evHook (ClientMessageEvent _ _ _ dpy win typ dat) = do
  state <- getAtom "_NET_WM_STATE"
  fullsc <- getAtom "_NET_WM_STATE_FULLSCREEN"
  isFull <- runQuery isFullscreen win

  -- Constants for the _NET_WM_STATE protocol
  let remove = 0
      add = 1
      toggle = 2

      -- The ATOM property type for changeProperty
      ptype = 4 

      action = head dat

  when (typ == state && (fromIntegral fullsc) `elem` tail dat) $ do
    when (action == add || (action == toggle && not isFull)) $ do
         io $ changeProperty32 dpy win state ptype propModeReplace [fromIntegral fullsc]
         fullFloat win
    when (head dat == remove || (action == toggle && isFull)) $ do
         io $ changeProperty32 dpy win state ptype propModeReplace []
         tileWin win

  -- It shouldn't be necessary for xmonad to do anything more with this event
  return $ All False

evHook _ = return $ All True
