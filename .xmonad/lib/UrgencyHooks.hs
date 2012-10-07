module UrgencyHooks 
    ( (|!|)
    , AudioUrgencyHook(..)
    , GTKUrgencyHook(..)
    , NotifyUrgencyHook(..)
    , StatusbarUrgencyHook(..)
    ) where

import XMonad
import qualified XMonad.StackSet as W

import XMonad.Hooks.UrgencyHook

import XMonad.Util.NamedWindows (getName)

-- | Chain together multiple UrgencyHooks; they will be fired in sequence from
-- left to right when the hook is called.
--
-- > withUrgencyHook (DzenUrgencyHook |!| AudioUrgencyHook "~/beepsound.wav")
(|!|) :: (UrgencyHook a, UrgencyHook b) => a -> b -> CombinedUrgencyHook a b
(|!|) = CombinedUrgencyHook

data CombinedUrgencyHook a b = CombinedUrgencyHook a b
    deriving (Read, Show)

instance (UrgencyHook a, UrgencyHook b) => UrgencyHook (CombinedUrgencyHook a b) where
    urgencyHook (CombinedUrgencyHook x y) w = urgencyHook x w >> urgencyHook y w

-- | Spawn `aplay` to play the audio file given.
data AudioUrgencyHook = AudioUrgencyHook FilePath
    deriving (Read, Show)

instance UrgencyHook AudioUrgencyHook where
    urgencyHook (AudioUrgencyHook a) = const . spawn . unwords $ ["aplay", a]

-- | Plays the message sound from your GTK sound theme.
data GTKUrgencyHook = GTKUrgencyHook
    deriving (Read, Show)

instance UrgencyHook GTKUrgencyHook where
    urgencyHook GTKUrgencyHook = const . spawn . unwords $ ["canberra-gtk-play", "-i", "message"]

--- | Spawns `notify-send` to provide indication of an urgent window.
data NotifyUrgencyHook = NotifyUrgencyHook
    deriving (Read, Show)

instance UrgencyHook NotifyUrgencyHook where
    urgencyHook NotifyUrgencyHook w = do
        name <- getName w
        ws <- gets windowset
        whenJust (W.findTag w ws) (flash (show name))
        where flash name index = spawn $ unwords 
                [ "notify-send"
                , summary name
                , body name index
                ]
              summary name = quote . unwords $ ["urgent:", name]
              body name index = quote . unwords $ ["urgent alert from", name, "on workspace", index]

data StatusbarUrgencyHook = StatusbarUrgencyHook
    deriving (Read, Show)

instance UrgencyHook StatusbarUrgencyHook where
    urgencyHook StatusbarUrgencyHook w = do
        name <- getName w
        ws <- gets windowset
        whenJust (W.findTag w ws) (flash (show name))
        where flash name index = return () -- putToStatusbar $ body name index
              body name index = quote . unwords $ ["urgent alert from", name, "on workspace", index]

wrap :: [a] -> [a] -> [a] -> [a]
wrap pre suf = (pre ++) . (++ suf)

quote :: String -> String
quote = wrap "\"" "\""
