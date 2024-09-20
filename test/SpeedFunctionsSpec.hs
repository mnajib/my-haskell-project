module SpeedFunctionsSpec (spec) where

-- module Main (main) where
-- module Main where

-- src/SpeedFunctions.hs
import SpeedFunctions
-- import System.IO.Silently (capture_)
import System.IO.Silently
-- hspec is the library we use for testing. hCapture_
import Test.Hspec

-- main :: IO ()
-- main = hspec $ do
spec :: Spec
spec = do
  describe "Speed calculation" $ do
    it "calculates speed correctly with meters and seconds" $ do
      let distance = (100.0, "meters")
          time = (10.0, "seconds")
          -- expectedSpeed = "Speed: 10.0 meters/seconds\n"
          expectedSpeed = "Distance: 100.0 meters, Time: 10.0 seconds\nSpeed: 10.0 meters/seconds\n"
      speedOutput <- captureSpeedOutput distance time
      speedOutput `shouldBe` expectedSpeed

    it "calculates speed with kilometers and hours" $ do
      let distance = (100.0, "kilometers")
          time = (2.0, "hours")
          -- expectedSpeed = "Speed: 50.0 kilometers/hours\n"
          expectedSpeed = "Distance: 100.0 kilometers, Time: 2.0 hours\nSpeed: 50.0 kilometers/hours\n"
      speedOutput <- captureSpeedOutput distance time
      speedOutput `shouldBe` expectedSpeed

-- Helper function to capture the output of the speed function
captureSpeedOutput :: (Double, String) -> (Double, String) -> IO String
captureSpeedOutput distance time = do
  -- Using the original speed function but redirecting output
  -- result <- hCapture_ [stdout] (speed distance time)
  -- result <- capture_ (speed distance time)
  -- return result
  capture_ (speed distance time)
