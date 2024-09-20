module Main where

import MathFunctions (addTwoNumbers, divideTwoNumbers, factorial, fibonacci, isPrime, multiplyTwoNumbers, pythagorean, subtractTwoNumbers, sumList)

main :: IO ()
main = do
  putStrLn "Basic Haskell Math Functions"
  print $ "Addition (3 + 5): " ++ show (addTwoNumbers 3 5)
  print $ "Subtraction (10 - 7): " ++ show (subtractTwoNumbers 10 7)
  print $ "Multiplication (4 * 6): " ++ show (multiplyTwoNumbers 4 6)
  print $ "Division (20 `div` 4): " ++ show (divideTwoNumbers 20 4)
  print $ "Sum of list [1, 2, 3, 4, 5]: " ++ show (sumList [1, 2, 3, 4, 5])
  print $ "Fibonacci of 6: " ++ show (fibonacci 6)
  print $ "Factorial of 5: " ++ show (factorial 5)
  print $ "Pythagorean for sides 3 and 4: " ++ show (pythagorean 3 4)
  print $ "Is 7 prime?: " ++ show (isPrime 7)
