> module Hw11
> where

Defining the function factorial, where Haskell will infer the type

> factorial n = if n == 0 then 1 else n * factorial(n - 1)

1c) An if statement checks for a condition and executes if true. An if expression returns the checked result

1f) From typing in the check "factorial 5" we get the expected answer of 120.
The inferred type of factorial is a function that takes either an equation or number and returns an equation or number. (factorial :: (Eq p, Num p) => p -> p)

> fact1 :: Int -> Int
> fact1 n = if n == 0 then 1 else n * fact1(n - 1)
> fact2 :: Integer -> Integer
> fact2 n = if n == 0 then 1 else n * fact2(n - 1)

4) When testing factorial, fact1, and fact2 with the same inputs:
12 resulted in the same answer for all functions
13 resulted in the same answer for all functions
500 resulted in the same answer for factorial and fact2, but fact1 showed 0

This happens because Int is a 32-bit number, and overflows fairly quickly when trying to calculate factorials. Integer is similar to the BigInteger class in Java, and can hold an unspecified size. factorial, with its generalized implementation, will pick the right type for the job based on compile-time information.

5) When typing factorial(-2) the program spirals out of control tryign to multiply factorial(-2) *  factorial(-3) * factorial(-4) * ... because our break statement only checks for 0. You would need to modify your check to account for negative inputs.

Typing "factorial -2" into the prompt results in an error because the -2 is not bound as a negative number correctly. Re-entering it as "factorial (-2)" will again cause the program to recurse towards negative infinity.

> factP :: Integer -> Integer
> factP 0 = 1
> factP n = n * factP(n - 1)

Running factP with the same inputs as before (12, 13, 500) we get the same (correct) outputs as factorial and fact2.

> factG x
>     | x < 0 = error "neg x"
>     | x == 0 = 1
>     | otherwise = x * factG(x - 1)


7) There are 3 definitions. The checks break down to being (x < 0), (x == 0), (x > 0)

Calling factG with a negative number, such as (-2) results in an error:
Hw11> factG(-2)
*** Exception: neg x
CallStack (from HasCallStack):
  error, called at Hw11.lhs:36:17 in main:Hw11

> factG2 :: Integer -> Integer
> factG2 n
>    | n < 0 = error "neg n"
>    | n == 0 = 1
>    | otherwise = n * factG2(n - 1)
> factE :: Integer -> Integer
> factE n
>    | n < 0 = error "neg n"
>    | n == 0 = 1
>    | otherwise = n * factE n - 1

8) When trying factorial 5.1, we recurse towards negative infinity as our break condition does not account for the Fraction correctly, and will miss its break case. factG breaks because it will also miss its breakcase of n == 0, but the catch-all of n < 0 will throw an error once it gets to the 6th recursion. factG2 5.1 will not compile as you are trying to pass a Fractional Integer in the place of a normal Integer, as we defined the type to hold. factG is a run-time error, factG2 is a compile-time error.

factG2 5 returns the (correct) result of 120. factE 5 recurses continuously. While I cannot see into the method, my assumption is the program is trying to execute factE 5 as 5 * factE(5) - 1, which does not decrement n and continues trying to solve the same equation over and over forever.