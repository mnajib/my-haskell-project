-- module Acceleration where
module Main where

import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [initialSpeed, finalSpeed, time] -> do
      let u = read initialSpeed :: Double
          v = read finalSpeed :: Double
          t = read time :: Double
      putStrLn $ "Acceleration: " ++ show ((v - u) / t) ++ " units per time squared"
    _ -> putStrLn "Usage: acceleration <initialSpeed> <finalSpeed> <time>"
