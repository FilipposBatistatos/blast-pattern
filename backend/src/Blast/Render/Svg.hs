module Blast.Render.Svg
    ( ringSvg
    , holeSvg
    , svgDocument
    ) where

import Blast.Pattern
import Blast.Simulate

-- Wavefront
ringSvg :: Wave -> String
ringSvg w = 
    "<circle cx=\"" ++ show x
      ++ "\" cy=\"" ++ show y
      ++ "\" r=\""  ++ show (waveRadius w)
      ++ "\" fill=\"none\" stroke=\"steelblue\" stroke-width=\"1\""
      ++ " vector-effect=\"non-scaling-stroke\" />"
    where
        (x, y) = holePos (waveHole w)

-- The hole from which the wave front propagates 
holeSvg :: Hole -> String
holeSvg h = 
    "<circle cx=\"" ++ show x ++ "\" cy=\"" ++ show y
      ++ "\" r=\"0.15\" fill=\"white\" />"
    where 
        (x, y) = holePos h

svgDocument :: [Hole] -> [Wave] -> String
svgDocument _ [] = "<svg xmlns=\"http://www.w3.org/2000/svg\" />"
svgDocument hs ws = 
    unlines ([header] ++ map ringSvg ws ++ map holeSvg hs ++ ["</svg>"])
    where
        xmin = minimum [ fst (holePos (waveHole w)) - waveRadius w | w <- ws ]
        xmax = maximum [ fst (holePos (waveHole w)) + waveRadius w | w <- ws ]
        ymin = minimum [ snd (holePos (waveHole w)) - waveRadius w | w <- ws ]
        ymax = maximum [ snd (holePos (waveHole w)) + waveRadius w | w <- ws ]
        box = unwords (map show [xmin, ymin, xmax - xmin, ymax - ymin])
        header = 
            "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"" ++ box ++ "\" width=\"800\">"
