Tuple Data Type

> prodT(a, b, c) = a * b * c

Type inferred seems to be a Num/Int

Curried Functions

> prodC a b c = a * b * c

Type inferred seems to be Num/Int again

> prodCx :: Num a => a -> (a -> (a -> a))
> prodCx a b c = a * b * c

The inferred type of prodC and prodCx appear to be the same

> prodC1 = prodC 1
> prodC2 = prodC1 2
> prodC3 = prodC2 3
> prodC12 = prodC 1 2

Prediction:
1, 2, 6, 2

Actual:
prodC1 and prodC2 are replacements
calling prodC3 will replace it with prodC1 2 3 => prodC 1 2 3

 prodT1 = prodT 1
 prodT2 = prodT(1)
 prodT4 = prodT(1, 2)
 prodT3 = prodT(1, x, y)

Quiz stuff:

> foo x y z = x + y + z

> one = (+) 1
> two = (*) 2
> three = (-) 3

Haskell is F G H = (F G) H

f(x) = 3 - (x * 5)
g(x) = (x - 1) * 2

h = fog(x)
h2 = gof(x)

h(x) = 3 - ((x - 1) * 2 ) * 5
h2(x) = (3 - (x * 5)) - 1) * 2

h(2) = 3 - ((2-1) * 2) * 5 = -7
h2(2) = (3-(2*5)) - 1) * 2 = -16

> f x = 3 - (x * 5)
> g x = (x - 1) * 2
> h = f . g
> h2 = g . f

___

Num a => a -> a -> a
Function that takes two args of type from Num (Int, etc.) and returns same type.

Num a => a -> (a -> a)
Function that takes one arg of type from Num and a function that returns the same type. This function returns the inner function.

Eq a => a -> a -> Bool
Function that takes two equations and returns a bool

(a -> b) -> [a] -> [b]
Function that takes any types a and b, and returns a tuple of list of a's and b's 


----

(+) 1
Num a => a -> a
(+) 1 :: Num a => a -> a

(+) 1 2
Num a => a -> a -> a
(+) 1 2 :: Num a => a

(.) (\x => x * 2)
idk
(.) (\x -> x * 2) :: Num c => (a -> c) -> a -> c

(.) (\x -> x * 2) abs
Num a, b => (a -> b) -> a -> b
(.) (\x -> x * 2) abs :: Num c => c -> c

(.) (+)
Num t => (t -> u) -> t -> u
(.) (+) :: Num a1 => (a2 -> a1) -> a2 -> a1 -> a1

(.) (+) (\m -> 10 * m) 
Num t => t -> t
(.) (+) (\m -> 10 * m) :: Num a => a -> a -> a

(.) (+) (\m -> 10 * m) 3 
Num t => t -> t
(.) (+) (\m -> 10 * m) 3 :: Num a => a -> a

> data Point a = Pt a a deriving (Show, Eq)

Data type name is Point
Constructor name is Pt

If not using deriving for Eq, no way to eval the type
