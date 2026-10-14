module Main (main) where

import Options.Applicative 

import Blast.Pattern
import Blast.Simulate
import Blast.Render.Svg

data Options = Options
    { optPattern :: Pattern
    , optAt      :: Double -- Simulation time in ms
    , optSpeed   :: Double -- m/ms
    } 

patternParser :: Parser Pattern    
patternParser = Pattern
    <$> option auto (long "rows"      <> metavar "N"  <> help "Number of rows")
    <*> option auto (long "cols"      <> metavar "N"  <> help "Holes per row")
    <*> option auto (long "burden"    <> metavar "M"  <> help "Distance between rows in meters")
    <*> option auto (long "spacing"   <> metavar "M"  <> help "Distance between holes in a row in meters")
    <*> option auto (long "row-delay" <> metavar "MS" <> help "Delay between rows in meters")
    <*> option auto (long "hole-delay"<> metavar "MS" <> help "Delay between holes in a row in meters")

optionsParser :: Parser Options
optionsParser = Options
    <$> patternParser
    <*> option auto (long "at"    <> metavar "MS"   <> help "Time to simulate in ms")
    <*> option auto (long "speed" <> metavar "M/MS" <> value 4 <> showDefault <> help "Wave speed in m/ms")

main :: IO ()
main = do
    opts <- execParser (info (optionsParser <**> helper)
        (fullDesc <> progDesc "Print an SVG of a blast pattern at a given time"))
    let hs = holes (optPattern opts)
        ws = wavesAt (optSpeed opts) (optAt opts) hs
    putStr (svgDocument hs ws)

