-- src/MathFunctions.hs
module MathFunctions where

addTwoNumbers :: Int -> Int -> Int
addTwoNumbers x y = x + y

subtractTwoNumbers :: Int -> Int -> Int
subtractTwoNumbers x y = x - y

multiplyTwoNumbers :: Int -> Int -> Int
multiplyTwoNumbers x y = x * y

divideTwoNumbers :: Int -> Int -> Int
divideTwoNumbers x y = x `div` y

sumList :: [Int] -> Int
sumList [] = 0
sumList (x:xs) = x + sumList xs

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

pythagorean :: Double -> Double -> Double
pythagorean a b = sqrt (a^2 + b^2)

isPrime :: Int -> Bool
isPrime n
  | n <= 1 = False
  | otherwise = null [ x | x <- [2..n-1], n `mod` x == 0]
