module Blast.Pattern
    ( Pattern (..)
    , Point
    , Hole (..)
    , holes
    ) where

-- The physical position of a hole
type Point = (Double, Double)

-- The pattern itself
data Pattern = Pattern 
    { patRows       :: Int -- Number of rows
    , patCols       :: Int -- Number of cols
    , patBurden     :: Double -- Burden (distance to the face of the blast)
    , patSpacing    :: Double -- Spacing (distance between holes in a row)
    , patRowDelay   :: Double -- Delay between rows in ms
    , patHoleDelay  :: Double -- Delay between holes in a row in ms
    } deriving (Show, Eq)

data Hole = Hole 
    { holeRow :: Int    -- Row number
    , holeCol :: Int    -- Col number
    , holePos :: Point  -- Position for rendering
    , holeFire :: Double-- Hold blast time
    } deriving (Show, Eq)

holes :: Pattern -> [Hole]
holes p = 
    [ Hole r c (x, y) t
    | r <- [0 .. patRows p - 1]
    , c <- [0 .. patCols p - 1]
    , let x = fromIntegral c * patSpacing p 
    , let y = fromIntegral r * patBurden p
    , let t = fromIntegral r * patRowDelay p + fromIntegral c * patHoleDelay p
    ]
