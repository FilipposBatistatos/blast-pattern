module Blast.Simulate
    ( Wave (..)
    , dist
    , wavesAt
    , overlaps
    , overlapCount
    ) where

import Blast.Pattern

data Wave = Wave 
    { waveHole   :: Hole
    , waveRadius :: Double
    } deriving (Show, Eq)

dist :: Point -> Point -> Double
dist (x1, y1) (x2, y2) = sqrt ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) 

-- speed (m/ms) -> time (ms) -> holes -> waves 
wavesAt :: Double -> Double -> [Hole] -> [Wave]
wavesAt speed t hs = 
    [ Wave h (speed * (t - holeFire h)) | h <- hs, holeFire h <= t ]

-- Do two circles overlap
overlaps :: Wave -> Wave -> Bool
overlaps a b = 
    dist (holePos (waveHole a)) (holePos (waveHole b))
        < waveRadius a + waveRadius b

-- How many otherwaves does this wave overlap
overlapCount :: [Wave] -> Wave -> Int
overlapCount ws w = length [ o | o <- ws, o /= w, overlaps w o]

