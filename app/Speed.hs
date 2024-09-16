--module Speed where
module Main where

import System.Environment (getArgs)
import System.Exit (exitFailure)
import Data.List (words)

-- Function to print help message
printHelp :: IO ()
printHelp = putStrLn "Usage: speed <distance> <time>\n\
\Calculate speed given distance and time.\n\
\Arguments:\n\
\  <distance>  Distance traveled\n\
\  <time>      Time taken to travel the distance"

-- Function to handle incorrect input
handleError :: IO ()
handleError = putStrLn "Error: Invalid input.\n" >> printHelp

-- Function that processes speed data
speed :: (Double, String) -> (Double, String) -> IO ()
speed distance time = do
  let
    (distanceValue, distanceUnit) = distance
    (timeValue, timeUnit) = time
  putStrLn $ "Distance: " ++ show distanceValue ++ " " ++ distanceUnit ++
             ", Time: " ++ show timeValue ++ " " ++ timeUnit
  putStrLn $ "Speed: " ++ show (distanceValue / timeValue)

-- Main app function
main :: IO ()
main = do
  let
    distance = (60.0, "meter")
    time = (120, "saat" )
  speed distance time
