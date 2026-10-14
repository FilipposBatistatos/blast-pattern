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
    , patBurden     :: Int -- Burden (distance to the face of the blast)
    , patSpacing    :: Int -- Spacing (distance between holes in a row)
    , patRowDelay   :: Int -- Delay between rows
    , patHoleDelay  :: Int -- Delay between holes in a row
    } deriving (Show, Eq)

data Hole = Hole 
    { holeRow :: Int    -- Row number
    , holeCol :: Int    -- Col number
    , holePos :: Point  -- Position for rendering
    , holeFire :: Double-- The size of the blast
    } deriving (Show, Eq)

holes :: Pattern -> [Hole]
holes p = 
    [ Hole r c (fromIntegral c * patSpacing p, fromIntegral r * patBurden p) t
    | r <- [0 .. patRows p - 1]
    , c <- [0 .. patCols p - 1]
    , let t = fromIntegral r * patRowDelay p + fromIntegral c * patHoleDelay p
    ]
