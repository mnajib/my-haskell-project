module Main where

import SpeedFunctions -- src/SpeedFunctions.hs
import System.Environment (getArgs) -- getArgs to capture user input (arguments)
import System.Exit (exitFailure) -- import Data.List (words)

-- Function to print help message
printHelp :: IO ()
printHelp =
  putStrLn
    "Usage: speed <distanceValue> <distanceUnit> <timeValue> <timeUnit>\n\
    \Calculate speed given distance and time.\n\
    \Arguments:\n\
    \  <distanceValue>  Distance value (numeric)\n\
    \  <distanceUnit>   Unit for distance (e.g., meters, kilometers)\n\
    \  <timeValue>      Time value (numeric)\n\
    \  <timeUnit>       Unit for time (e.g., seconds, hours)"

-- Function to handle incorrect input
handleError :: IO ()
handleError = putStrLn "Error: Invalid input.\n" >> printHelp >> exitFailure

-- Function that calculate speed
-- speed :: (Double, String) -> (Double, String) -> IO ()
-- speed distance time = do
--  let
--    (distanceValue, distanceUnit) = distance
--    (timeValue, timeUnit) = time
-- speed (distanceValue, distanceUnit) (timeValue, timeUnit) = do
-- putStrLn $ "Distance: " ++ show distanceValue ++ " " ++ distanceUnit ++
--           ", Time: " ++ show timeValue ++ " " ++ timeUnit
-- putStrLn $ "Speed: " ++ show (distanceValue / timeValue)
-- putStrLn $ "Speed: " ++ show (distanceValue / timeValue) ++ " " ++ distanceUnit ++ "/" ++ timeUnit

-- Main app function
main :: IO ()
main = do
  --  let
  --    distance = (60.0, "meter")
  --    time = (120, "saat" )
  args <- getArgs -- the program now captures user input uisg getArgs
  case args of
    -- Expecting exactly 4 arguments
    [distanceValueStr, distanceUnit, timeValueStr, timeUnit] -> do
      let maybeDistanceValue = reads distanceValueStr :: [(Double, String)]
      let maybeTimeValue = reads timeValueStr :: [(Double, String)]
      case (maybeDistanceValue, maybeTimeValue) of
        ([(distanceValue, "")], [(timeValue, "")]) -> do
          -- we pattern-match on [(distanceValue, "")] and [(timeValue, "")] to ensure the input is valid
          -- Both distance and time values are successfully parsed
          -- speed distance time
          speed (distanceValue, distanceUnit) (timeValue, timeUnit)
        _ -> handleError

    -- If the number of arguments is incorrect
    _ -> handleError
