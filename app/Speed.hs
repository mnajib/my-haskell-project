--module Speed where
module Main where

import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    case args of
        [distance, time] -> do
            let dist = read distance :: Double
                t = read time :: Double
            putStrLn $ "Speed: " ++ show (dist / t) ++ " units per time"
        _ -> putStrLn "Usage: speed <distance> <time>"
