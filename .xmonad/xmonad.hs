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
	, className =? "Vncviewer" --> doFloat
	]

-- , terminal = "konsole"
main = do
	dzentop <- spawnPipe myTopBar
	xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
		{ manageHook = manageDocks <+> myManageHook
					   <+> manageHook defaultConfig
		-- , layoutHook = avoidStruts $ layoutHints (layoutHook defaultConfig)
		, layoutHook = myLayout
		, logHook = dynamicLogWithPP $ myDzenPP dzentop
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
	, ((mod1Mask .|. shiftMask, xK_q), spawn "gnome-session-save --gui --kill")
	]

-- Statusbar options
myTopBar = "dzen2 -bg $NORMBGCOLOR -fg $NORMFGCOLOR -ta l -w $(($WIDTH - $RBARWIDTH)) -x 0 -fn '*-*-*-r-*-*-14-*-*-*-*-*-iso8859-*'"
-- Statusbar pretty printer
myDzenPP h = defaultPP
	{ ppCurrent = wrap "^fg(#0099ff)^bg(#333333)^p()^fg(#ffffff)" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
	, ppVisible = wrap "^fg(#ffffff)^bg(#333333)^p()^fg(#ffffff)" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
	, ppHidden = wrap "^fg(#004c7f)^bg(#333333)^fg()" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId -- don't use ^fg() here!!
	, ppHiddenNoWindows = wrap "^fg(#777777)^bg()^p()" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
	, ppUrgent = wrap "^fg(#0099ff)^bg()^p()" "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
	, ppSep = " "
	, ppWsSep = " "
	, ppTitle = dzenColor "#ffffff" "" . wrap "< " " >"
	, ppLayout = dzenColor "#ffffff" "" .
		(\x -> case x of
		"Hinted Tall" -> "H-Tall"
		"Hinted Wide" -> "H-Wide"
		"Hinted Full" -> "H-Full"
		"Hinted Mirror Tall" -> "H-Mirror Tall"
		_ -> x
		)
	, ppOutput = hPutStrLn h
	}
