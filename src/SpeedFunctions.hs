module SpeedFunctions where

speed :: (Double, String) -> (Double, String) -> IO ()
speed (distanceValue, distanceUnit) (timeValue, timeUnit) = do
  putStrLn $ "Distance: " ++ show distanceValue ++ " " ++ distanceUnit ++
           ", Time: " ++ show timeValue ++ " " ++ timeUnit
  putStrLn $ "Speed: " ++ show (distanceValue / timeValue) ++ " " ++ distanceUnit ++ "/" ++ timeUnit
