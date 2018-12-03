Zachary Halpern

> module Hw12
>     where

Problem 1:
Write a function "prodALL" that takes a list of numbers and returns their product.
This must be a recursive solution.
Example:
...> prodALL [2,7,4]
56

Problem 1 Answer:

> prodALL :: Num a => [a] -> a
> prodALL [] = 0
> prodALL [head] = head
> prodALL (head:tail) = head * prodALL tail


Problem 2:
Write a function "binOpALL op lst" that takes an arbitrary binary operator and
a list of numbers and returns the result of applying the 'op' to the values in
list. To make things easy use the prefix notation for the operators,
e.g. (*) 3 2 evaluates to 6.
Example:
...> binOpALL (+) [2,7,4]
13

Problem 2 Answer:

> binOpALL :: Num a => (a -> a -> a) -> [a] -> a
> binOpALL op [] = 0
> binOpALL op [head] = head
> binOpALL op (head:tail) = op head (binOpALL op tail)


Problem 3:  Write a function prodALLC that behaves like prodALL (problem 1)
            Your definition must use a partial evaluation of prodALL.
Example:
...> prodALLC [2,7,4]
56

Problem 3 Answer:

> prodALLC :: Num a => [a] -> a
> prodALLC [] = 0
> prodALLC [head] = prodALL [head]
> prodALLC (head:tail) = head * (prodALL tail)

Problem 4:
Write a recursive function "insertAt v p lst" that inserts a value v at
position p in list lst. If p is greater than the length of lst, simply
insert it at the end.
Example:
...> insertAt 12 1 [1,2,3]
[1,12,2,3]
...> insertAt 12 10 [1,2,3]
[1,2,3,12]

Remember, Haskell is "pure", so you can not modify lst. Instead, you should
recurse and build a new list from lst with v inserted. 

Problem 4 Answer:

> insertAt :: (Eq a, Num a) => b -> a -> [b] -> [b]
> insertAt value index [] = [value]
> insertAt value 0 (head:tail) = [value] ++ [head] ++ tail
> insertAt value index (head:tail) = [head] ++ insertAt value (index - 1) tail


Problem 5. Thompson 10.3
Define a function composeList which composes a list of unary functions into a 
single function. You may assume the list of functions is not empty.
Define composeList using primitive recursion.
Example:
...> composeList [ (*) 2, (*) 2] 2
8
...> composeList [ (-) 3 , (*) 2, (+)5 ] 7 
-21
Notice how in the above example, the output of composeList [ (-) 3, (*) 2, (+) 5]
is the function f(x) = (3 - (2 * (5 + x))).

Problem 5 Answer:

> composeList [head] = head
> composeList (head:tail) = head . composeList tail


Problem 6: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
"In mathematics, the Thue-Morse sequence, or Prouhet-Thue-Morse sequence, is a 
binary sequence that begins:

  0 01 0110 01101001 0110100110010110 01101001100101101001011001101001 ...

(or if the sequence started with 1...)
    1 10 1001 10010110 1001011001101001 ...

"Characterization using bitwise negation

The Thue Morse sequence in the form given above, as a sequence of bits, 
can be defined recursively using the operation of bitwise negation. So, the 
first element is 0. Then once the first 2n elements have been specified, 
forming a string s, then the next 2n elements must form the bitwise negation of 
s. Now we have defined the first 2n+1 elements, and we recurse.

Spelling out the first few steps in detail:

    * We start with 0.
    * The bitwise negation of 0 is 1.
    * Combining these, the first 2 elements are 01.
    * The bitwise negation of 01 is 10.
    * Combining these, the first 4 elements are 0110.
    * The bitwise negation of 0110 is 1001.
    * Combining these, the first 8 elements are 01101001.
    * And so on.
So the sequence is
    * T0 = 0
    * T1 = 01
    * T2 = 0110
	...
    
Define a primitive recursive function 'thue' given the nth thue element returns
the next thue element.  The elements will be represented as a list of 0s and 1s.
Example:
...> thue [0,1,1,0]
[0,1,1,0,1,0,0,1]

Problem 6 Answer:

> thue list = list ++ thue_helper list
> thue_helper [] = []
> thue_helper (0:tail) = 1 : thue_helper tail
> thue_helper (1:tail) = 0 : thue_helper tail


Problem 7:
Define a function replicate' which given a list of numbers returns a 
list with each number duplicated its value. The ' is not a typo - this is to
avoid the existing replicate.
Use primitive recursion in your definition.
You may use a nested helper definition.
Example:
...> replicate' [2, 4, 1]
[2,2,4,4,4,4,1]

Problem 7 Answer:

> replicate' list = [x | x <- list, _ <- [1..x]]


Problem 8:
In homework 1 you were introduced to the Ackermann Numbers.
The definition we used in the assignment is:

	ack( m,n ) =	n + 1			    if m = 0
	ack( m,n ) =	ack(m - 1, 1)		    if n = 0 and m > 0 
	ack( m,n ) =	ack( m-1, ack( m, n-1 ) )   if n >0 and m > 0

Define the ack function in Haskell.
Example:
...> ack 0 3
4
...> ack 3 2
29

Problem 8 Answer:

> ack m n
>	| (m == 0) 			= (n + 1)
>	| (n == 0 && m > 0)	= (ack (m - 1) 1)
>	| (n > 0 && m > 0) 	= (ack (m - 1) (ack m (n - 1)))
>	| otherwise 		= 0


Problem 9:
A Define sumHarmonic using a simple recursive style:

The harmonic series is the following infinite series:
                1   1   1   1             1
            1 + - + - + - + - + ... + ... - ...
                2   3   4   5             i
(http://en.wikipedia.org/wiki/Harmonic_series_(mathematics))
Write a function sumHarmonic such that sumHarmonic i is the sum of the first i
terms of this series. For example, sumHarmonic 4 ~> 1 + 1 + 1 + 1 ~> 2.08333...
                                                        2   3   4
Example:
...> sumHarmonic 4
2.08333...

Problem 9 Answer:
Note: this type is not required; you may have a slightly different type
depending on your solution.

> sumHarmonic x
> 	| x == 1 	= 1
>	| x > 1 	= (1 / x) + sumHarmonic (x - 1)
>	| otherwise = error "neg x"


Problem 10: 
Implement Newton's method for calculating the square root of N.
Your definition should use primitive recursive style.
See (http://bingweb.binghamton.edu/~head/CS471/HW/Haskell2F18.html) webpage for
a definition of Newton method for the approximation of roots. 
Your definition should include a user defined (input) "guess" value and a user 
defined "nearEnough" value.  
"nearEnough" is use to determine when the guess is close enough to the square root. 
You should use locally defined helper functions to make your code more readable. 

Example: 
...> newtonAppr 144 1 0.1             
12.000545730742438 
...> newtonAppr 144 1 0.0001
12.0000000124087
...> newtonAppr 144 1 0.000000000000001
12.0
...> newtonAppr 5e+30 1 1000000000000000000000000000000  
2.317148867384728e15
...> newtonAppr 5e+30 1 100000000000000000000000000    
2.2360684271923805e15

Problem 10 Answer:
Note: again, you may have a slightly different type depending on your
solution.

> newtonAppr :: (Fractional a, Ord a) => a -> a -> a -> a
> newtonAppr numToSqRoot guess tolerance =
>	 let guessSquared 	= guess * guess
>	 in if (guessSquared <= numToSqRoot + tolerance && guessSquared >= numToSqRoot - tolerance)
>	    then guess
>	    else newtonAppr numToSqRoot (((numToSqRoot / guess) + guess) / 2) tolerance
