> module Hw13
>    where

Problem 1: (Thompson 10.13 edition 2)
  Find functions f1 and f2 so that
 
   s1 =  map f1 . filter f2

  has the same effect as
 

> p1 = filter (>0) . map (+1)

 
  ....> p1 [-4,4, -3,3,12,-12]
  [5,4,13]
  (99 reductions, 153 cells)
  ....> s1 [-4,4, -3,3,12,-12]
  [5,4,13]
  (90 reductions, 137 cells)


For your answer, please define both f1 and f2, then remove the
space before the line that defines s1 to make it not a comment.
  
Problem 1 ANSWER:

> s1 =  map f1 . filter f2

> f1 :: Num a => a -> a
> f1 = (\x -> x + 1)

> f2 :: (Num a, Ord a) => a -> Bool
> f2 = (\x -> (x >= 0))



Problem 2. 
Using higher order functions (map, fold or filter) and if necessary lambda
expressions, write a definition for f3 and f4 so the following evaluation 
is valid:  (hint: a lambda expressions could be useful).

     f3 (f4 (*) [1,2,3,4]) 5  ~> [5,10,15,20]

     Main> f3 ( f4 (*) [1,2,3,4]) 5
     [5,10,15,20]
     (77 reductions, 123 cells)
	 
For your answer, please define both f3 and f4.

Problem 2 ANSWER:  

> f3 op argument = op argument
> f4 op list = (\x -> map (\y -> op x y) list)



Problem 3:
In a previous homework you defined a function composeList which composes 
a list of functions into a single function.
 
    ...> composeList [ (-) 2, (*) 5, (-) 3] 10
   37


Redo this problem using hof. The definition should use a 'fold' and it 
should be only be one line AND no explicit arguments,
e.g. composeListHOF = ...
For your answer please define composeListHOF.

composeListHOF [ (-) 2, (*) 5, (-) 3] 10
   
Problem 3 ANSWER:  
Trying to do:
(list[2] (list[1] (list[0] val)))

> composeListHOF :: (Foldable t0) => t0 (a -> a) -> a -> a
> composeListHOF = (\list -> foldr1 (.) list)


Problem 4: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
In a previous homework you wrote a primitive recursive function to produce the next element in the Thue-Morse sequence, (also know as Prouhet-Thue-Morse sequence)

One possible solution is 

> thue (s:sx) = (mod s 2) : (mod (s + 1) 2): thue sx
> thue [ ] = [ ]

  a) Redefine thue using 'map' instead of explicit recursion. My solution 
     was coded using (++), map, lambda expression and mod.  Call this
     function 'thueMap'.  This can be done with 1 line of code.

  b) Define thueSeq which is a sequence of "thue elements" using the circular
     list illustrated in class for fibseq
     (http://bingweb.binghamton.edu/~head/CS471/NOTES/HASKELL/4hF02.html)
     You may use thue OR thueMap in your definition of thueSeq.  Your solution
	 should use zipWith similar to fibseq.
	 This can be done with one line of code.
 
     *.......> thueMap [0,1,1,0,1,0,0,1]
      [0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0]

     *.......> take 4 thueSeq 
      [[0],[0,1],[0,1,1,0],[0,1,1,0,1,0,0,1]]

Your answer should define thueMap and thueSeq.

Problem 4 ANSWER:  

> thueMap list = list ++ map (\x -> (mod (x + 1) 2)) list
> thueSeq = [0] : [0, 1] : [x | x <- map thueMap (tail thueSeq)]
   
Problem 5:
Using a fold in your solution:

a) Define "allTrue" to evaluate a list of expression of Bools to True if all the expression in a list are true.  Your definition should be a curried (partially evaluated) function. (i.e. do not have an explicit parameters.  allTrue = ???)

b) Define "noneTrue"  which evaluates to True if none of the boolean expression in a list are true.  Your definition should be a curried (partially evaluated) function. (i.e. do not have an explicit parameters.  noneTrue = ???) (Hint: You should use compose to "glue" some of the functions so you don't need explicit parameters.)

Your answer should define allTrue and noneTrue.
	
Problem 5 ANSWER:  

> allTrue :: (Foldable t0) => t0 Bool -> Bool
> allTrue = (\list -> foldl1 (&&) list)
> noneTrue = (\list -> foldl1 (&&) (map not list))


Problem 6.
Using an  HOF (map, fold and/or filter) define flattenT that returns a list of
values in each tuple. For this problem you can assume each tuple will be a
pair, e.g. (x,y). 
The output should be in the same order as the values appear in the 
original list, e.g.

   ...> flattenT  [(1,2), (3,4), (11,21),(-5,45)] 
   [1,2,3,4,11,21,-5,45]
   
Your answer should define flattenT.

Problem 6 ANSWER:  

> tupleToList (x, y) = [x, y]
> flattenT list = foldl1 (++) (map tupleToList list)


Problem 7: flattenR is the same as 6, however, the values appear in the reverse order
   from the original list.
e.g.
   ...> flattenR  [(1,2), (3,4), (11,21),(-5,45)] 
   [45,-5,21,11,4,3,2,1]
   
flattenR should also be defined using HOF (and lamda expressions).

Your answer should define flattenR.

Problem 7 ANSWER:  

> flattenR list = foldl (\x y -> y:x) [] (flattenT list)

   
Problem 8: Write new definitions of this function:

> func = (\xs -> [ x * 5 - 1 | x <- xs, x > -1 ]) [6,25,-20,7]
  
   ...> f [6,25,-20,7]
   [29,124,34]


   Using explicit recursion and pattern-matching, without guards
   -- OR --
   using explicit recursion with guards but without pattern-matching.  You
   may use explicit arguments.

Your answer should define f.
   
Problem 8 ANSWER:  

> f (h:t)
>    | h > -1    = (h * 5 - 1) : f t
>    | otherwise = f t

> f [] = []

I tried to simplify a bit, but if it's not what was required here is what I emailed:
 > f (h:t)
 >    | h > -1 && length t > 0   = [(h * 5 - 1)] ++ (f t)
 >    | h > -1 && length t == 0  = [(h * 5 - 1)]
 >    | h <= -1 && length t > 0  = f t
 >    | h <= -1 && length t == 0 = []


Problem 9
Define a primitive recursive function 'merge' that given two sorted lists returns a sorted list with all the unique elements from lists. That is, the resulting list should be sorted, and not contain any elements that were in both lists.
e.g.
   ....> merge [1,8,9,100] [3,7,9,99,100]
   [1,3,7,8,9,99,100]

The lists may share elements between them, e.g.
   ....> merge [1,2,3,5,7] [1,2,3,5,7]
   [1,2,3,5,7]
However, neither list will contain duplicates internally, so you need not handle a case like merge [1,2,2,3] [2,3,4,4].

Your answer should define merge.

Problem 9 ANSWER: 

> merge (head1:tail1) (head2:tail2)
>   | head1 == head2  = head1 : merge tail1 tail2
>   | head1 < head2   = head1 : merge tail1 (head2:tail2)
>   | head1 > head2   = head2 : merge (head1:tail1) tail2

> merge [] list2 = list2
> merge list1 []  = list1


Problem 10:  (Thompson 17.25 )
Define the list of numbers whose only prime factors are 2, 3, and 5, the
so-called Hamming numbers:

   ...> take 15 hamming
   [1,2,3,4,5,6,8,9,10,12,15,16,18,20,24, ...

(Recall that "take" creates a list from the first n elements of a list, which can be useful for handling infinite lists.)
   
You may consider using any combinition of the following techiques to express your solution: list comprehension notation, and/or explicit recursion, and/or local definitions.  You may include your merge defined previously.

(Hint: Apply the circular list idea demostrated in fibSeq (http://bingweb.binghamton.edu/%7Ehead/CS471/NOTES/HASKELL/4hF02.html)) 

You may use factors but it will be very slow.

> factors :: Integer -> [Integer]
> factors x = 1:[a | a<-[2..(div x 2)], (mod x a) == 0] ++ [x]
           
Your answer should define hamming.

Problem 10 ANSWER:  

> hamming = 1 : merge (map (2*) hamming) (merge (map (3*) hamming) (map (5*) hamming))