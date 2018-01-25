{-# LANGUAGE FlexibleContexts #-}
--- vim:set nolist et tw=0 ts=4 sw=4 sts=4:

module MyLayouts
    ( myLayout
    ) where

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Combo
import XMonad.Layout.LayoutHints
import XMonad.Layout.Master
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation

goldenRatio = (toRational (2/(1+sqrt(5)::Double)))

createLayout name layout =
    renamed [Replace name] $
    layoutHints $
    smartBorders $
    layout

myFullLayout = createLayout "Full" $
    avoidStruts $
    Full

myTiledLayout = createLayout "Tall" $
    avoidStruts $
    Tall nMaster ratioIncrement masterRatio
    where
        nMaster = 1
        ratioIncrement = 3/100
        masterRatio = goldenRatio

myMirrorTiledLayout = createLayout "M-Tall" $
    avoidStruts $
    Mirror (Tall nMaster ratioIncrement masterRatio)
    where
        nMaster = 1
        ratioIncrement = 3/100
        masterRatio = goldenRatio

myTabbedTheme = defaultTheme {
    fontName = "xft:Dejavu Sans Mono:size=8"
    , decoHeight = 30
}

myTabbed = tabbed shrinkText myTabbedTheme
myTabbedLayout = createLayout "Tab" $
    avoidStruts $
    myTabbed

myTwoPaneLayout = createLayout "2Pane" $
    avoidStruts $
    TwoPane resizeDelta masterRatio
    where
        resizeDelta = 3/100
        masterRatio = goldenRatio

myTwoPaneTabbedLayout = createLayout "2PaneTab" $
    avoidStruts $
    combineTwo (TwoPane resizeDelta masterRatio) myTabbedLayout myTabbedLayout
    where
        resizeDelta = 3/100
        masterRatio = goldenRatio

myMasterTabbedLayout = createLayout "MTab" $
    avoidStruts $
    mastered (resizeDelta) (masterRatio) $
    myTabbed
    where
        resizeDelta = 3/100
        masterRatio = goldenRatio

myMirrorMasterTabbedLayout = createLayout "M-MTab" $
    avoidStruts $
    Mirror (mastered (resizeDelta) (masterRatio) $ Mirror(simpleTabbed))
    where
        resizeDelta = 3/100
        masterRatio = goldenRatio

-- This was the easiest way I found to avoid a compile error when I have
-- an unused layout
referenceAllLayoutsToAvoidErrors =
    myFullLayout |||
    myTiledLayout |||
    myMirrorTiledLayout |||
    myTabbedLayout |||
    myTwoPaneLayout |||
    myTwoPaneTabbedLayout |||
    myMasterTabbedLayout |||
    myMirrorMasterTabbedLayout

myLayout =
    (
        myTabbedLayout |||
        ---windowNavigation myTwoPaneTabbedLayout |||
        ---myMasterTabbedLayout |||
        ---myMirrorMasterTabbedLayout |||
        myTiledLayout |||
        myMirrorTiledLayout |||
        myFullLayout 
    )

