--- vim:set nolist noet tw=0 ts=4 sw=4 sts=4:

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.LayoutHints
import XMonad.Hooks.UrgencyHook
import System.IO

import qualified Data.Map as Map

myManageHook = composeAll
	[ className =? "Gimp" --> doFloat
	, className =? "Gimp-2.6" --> doFloat
	, className =? "Vncviewer" --> doFloat
	]

-- , terminal = "konsole"
main = do
	xmobar <- spawnPipe "/usr/bin/xmobar"
	xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
		{ manageHook = manageDocks <+> myManageHook
					   <+> manageHook defaultConfig
		-- , layoutHook = avoidStruts $ layoutHints (layoutHook defaultConfig)
		, layoutHook = myLayout
		-- , logHook = dynamicLogWithPP $ myDzenPP dzentop
		, logHook = myLogHook xmobar
		, keys = \c -> myKeys `Map.union` keys defaultConfig c
		, terminal = "gnome-terminal"
		, borderWidth = 2
		, normalBorderColor = "#cccccc"
		, focusedBorderColor = "#cd8b00" }

myLayout = avoidStruts $ layoutHints $ tiled ||| Mirror tiled ||| Full
	where
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = toRational (2/(1+sqrt(5)::Double))
		delta = 3/100

myKeys = Map.fromList $ [
	--- ((0, 0x1008ff14), spawn "mpc toggle")       -- XF86AudioPlay
	--- , ((0, 0x1008ff11), spawn "mpc volume -4")  -- XF86AudioLowerVolume
	--- , ((0, 0x1008ff13), spawn "mpc volume +4")  -- XF86AudioRaiseVolume
	--- , ((0, 0x1008ff81), spawn "mpc next")       -- XF86Tools
	((mod4Mask .|. shiftMask, xK_q), spawn "gnome-session-save --gui --kill")
	, ((mod1Mask .|. shiftMask, xK_q), spawn "gnome-session-save --logout-dialog")
	, ((mod1Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command --lock")
	, ((mod1Mask, xK_p), spawn "dmenu_run")
	]

-- Statusbar pretty printer
myLogHook h = dynamicLogWithPP $ xmobarPP
	{ ppOutput = hPutStrLn h
	, ppTitle = xmobarColor "green" "" . shorten 50
	}
