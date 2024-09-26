module Main where

import Control.Concurrent (threadDelay)
import Control.Concurrent.Async (async, wait)
import Data.Time.Clock (getCurrentTime, utctDayTime)
import System.IO (hFlush, stdout)

main :: IO ()
main = do
  putStrLn "Alarm Clock"
  putStrLn "Set an alarm for how many seconds from now?"

  input <- getLine
  let delayTime = read input :: Int

  putStrLn $ "Alarm set for " ++ show delayTime ++ " seconds."
  threadDelay (delayTime * 1000000) -- Convert seconds to microseconds
  putStrLn "Alarm! Time's Up!"
