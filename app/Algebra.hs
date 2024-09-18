-- TODO:
--   - refactor algebra?

--module Algebra where
module Main where

import MathFunctions (addTwoNumbers, subtractTwoNumbers, multiplyTwoNumbers, divideTwoNumbers, sumList, fibonacci, factorial, pythagorean, isPrime)

import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs

    putStrLn "Algebra Commands:"
    putStrLn "1. Addition of 3 and 7"
    putStrLn "2. Subtraction of 10 and 7"
    putStrLn "3. Multiplication of 4 and 6"
    putStrLn "4. Division of 20 by 4"
    putStrLn "5. Sum of list [1,2,3,4,5]"
    putStrLn "6. Fibonacci of 6"
    putStrLn "7. Factorial of 5"
    putStrLn "8. Pythagorean for sides 3 and 4"
    putStrLn "9. Check if 7 is prime"

    putStrLn "Choose an option (1-9):"
    option <- getLine
    case option of
        "1" -> print (addTwoNumbers 3 7)
        "2" -> print (subtractTwoNumbers 10 7)
        "3" -> print (multiplyTwoNumbers 4 6)
        "4" -> print (divideTwoNumbers 20 4)
        "5" -> print (sumList [1,2,3,4,5])
        "6" -> print (fibonacci 6)
        "7" -> print (factorial 5)
        "8" -> print (pythagorean 3 4)
        "9" -> print (isPrime 7)
        _   -> putStrLn "Invalid option"
