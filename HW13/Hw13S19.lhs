Maitri Mangal
CS471 Assignment HW13

> module Hw13S19
>     where

Problem 1: Define a data type Point that represents a point in a plane and the 
coordinate values should be polymorphic. The constructor for Point should be Pt.
You should include "deriving (Show, Eq)" in your data type definition.   What is
the purpose of  including "deriving"?  

Answer 1:

> data Point x = Pt x x deriving (Show, Eq)

The purpose of including deriving is to be able to derive the methods of Show and Equal so that we can 
use the funcitonalities of Show and Equal. Without that we cannot check if two points are equal or print
Points out
 

Problem 2 Write a Haskell function "inside point r " which returns true 
if and only if the point lies inside a circle of radius r and false otherwise.  

 "inside" can be defined as:
     inside r point (x, y) is true  if and only if x^2 + y^2 < r^2 
  where x and y are the coordinates of the point. For example:

   ....> inside 10.0 (Pt 3.0 2.5) 
   True 
What type is inferred of inside?

Answer 2:

> inside :: (Ord a, Num a) => a -> Point a -> Bool
> inside r (Pt a b) = if ((a^2)+(b^2)) < (r^2) then True else False

Problem 3.
This problem are related to tail recursion.  power is a function which raises a 
number n  to the power p. Here is a very simple implementation.   

> power :: Integer -> Integer -> Integer
> power n 0 = 1
> power n p = n * power n (p-1)

a) Show the steps in the evaluation of the expression power 2 5,  making sure 
   not to reduce any subexpression prematurely. How do the time and maximum 
   space required by the evaluation of power n k depend on n and p?  What is 
   the time complexity of power?

power 2 5 = 2 * power 2 (4)
	      = 2 * power 2 (3)
	      	= 2 * power 2 (2)
      		  = 2 * power 2 (1)
      		    = 2 * power 2 (0)
      		      = 1
Time complexity is O(n^2) as you have to reach the base case of 0 and then roll back up to get your actual answer. As the value of p goes up, the more time and memory is required. It grows exponentially.

  
b) Because of lazy evaluation, the definition of power accumulates of pending 
   multiplications. It is inherent in the way power is definedâ€” each 
   multiplication has to wait until its right argument has been evaluated. 
   One way to eliminate the multiplication delay is to convert the functionâ€™s 
   definition to a tail-recursive implementation:

> powerT :: Integer -> Integer -> Integer
> powerT n p = trp p 1
>    where
>    trp p' acc = if (p' == 0) then acc else trp (p'-1) (n*acc)

  Show the steps in the evaluation of the expression powerT 2 5, making sure not 
  to reduce any subexpression prematurely. What is the time complexity of powerT?

power 2 5 = trp 5 1
	   --> trp 4 2
	   --> trp 3 4
	   --> trp 2 8
	   --> trp 1 16
	   --> trp 0 32
	   --> 32

The time complexity of PowerT should just be O(n) as all it needs to do is go down the recrusion pass once and it will have the answer at the end once the base case is reached

c) Here is an algorithm that improves time and space

> turboPower a 0 = 1
> turboPower a b
>     | even b = turboPower (a*a) (b `div` 2)
>     | otherwise = a * turboPower a (b-1)

   Instead of merely decrementing its first argument, this algorithm halves it 
   whenever it is even, thereby reaching termination much more quickly. What is 
   the complexity of this algorithm? 

Since the complexity is being cut in half, the time complexity should just be O(n) as it goes down and cuts the algo in half, but it must also rewind back up to calculate the actual answer

d) Convert turboPower  to a tail recursive version -- call you new version 
   turboPowerT.   You can follow the pattern used in part b. What is the 
   complexity of this algorithm? 

The time complexity should just be O(n/2)

Answer 3:

> turboPowerT a b = trpt a b 1
> 	where 
> 	trpt a' b' acc
>		| b' == 0   = acc
>		| even b'   = trpt (a'*a') (b' `div` 2) acc
>		| otherwise = trpt a' (b'-1) (acc*a')  


Problem 4: 

The Tree data type defined below is used to build a binary tree. 
tree1, tree2 and tree3 are examples of binary tree.


> data Tree a =  Nil  
>              | Node a (Tree a) (Tree a) deriving Eq


> instance Show a => Show (Tree a) where
>  show t = show' t 0
>    where
>      show' Nil ind = replicate ind ' ' ++ "Nil"
>      show' (Node v l r) ind = 
>        replicate ind ' ' ++ "(Node " ++ show v ++ "\n" ++ 
>        show' l (ind+1) ++ "\n" ++
>        show' r (ind+1) ++ "\n" ++
>        replicate ind ' ' ++ ")"

What are Tree, Nil and Node?


I have also provided a few default binary trees so you do not need to 
keep entering them into ghci. You may simply type tree1 at the prompt and you
will get a pretty print of tree1. Note these 3 examples are in fact binary
search trees.

> tree1 = Node 5 (Node 10 Nil (Node 12 Nil Nil) ) Nil
> tree2 = (Node 5 (Node 2 (Node 1 Nil Nil) (Node 3 Nil Nil)) (Node 7 Nil (Node 9 Nil Nil)))
> tree3 = (Node 5 (Node 2 (Node 1 Nil Nil) Nil) (Node 7 Nil (Node 9 Nil Nil)))


Define "flatten t" which converts a tree to a list.  You should do an 
inorder traversal of the tree. You may use "++" operator. 
What are your assumptions?  Can you predict the most general type of flatten?

    ...> flatten tree1
    [10,12,5]

Answer 4:
   
> flatten :: Tree t -> [t]
> flatten Nil = []
> flatten (Node a l r) = flatten l ++ [a] ++ flatten r

Problem 5:
The harmonic series is the following infinite series:
                1   1   1   1             1
            1 + - + - + - + - + ... + ... - ...
                2   3   4   5             i
(http://en.wikipedia.org/wiki/Harmonic_series_(mathematics))

Write a function sumHarmonic such that sumHarmonic i is the sum of the first in
terms of this series. For example, sumHarmonic 4 ~> 1 + 1 + 1 + 1 ~> 2.08333...
                                                        2   3   4
Your answer should be in a simple recursive style.

Example:
...> sumHarmonic 4
2.08333...


Answer 5:

> sumHarmonic :: (Eq a, Fractional a) => a -> a
> sumHarmonic x 
>	      | x == 1	  = 1
>	      | otherwise = (1/x) + (sumHarmonic(x-1))


Problem 6: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
"In mathematics, the Thue-Morse sequence, or Prouhet-Thue-Morse sequence, is a 
binary sequence that begins:

  0 01 0110 01101001 0110100110010110 01101001100101101001011001101001 ...

(or if the sequence started with 1...)
    1 10 1001 10010110 1001011001101001 ...

"Characterization using bitwise negation

The Thueâ€“Morse sequence in the form given above, as a sequence of bits, 
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

 > thue :: (Eq a, Num a, Num a1) => [a] -> [a1]

> thue :: (Eq a, Num a) => [a] -> [a]
> thue a = a ++ (map (\x -> if x == 0 then 1 else 0) a)


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

> repeat' :: (Eq a, Eq b, Num b, Num a) => a -> b -> [a]
> replicate' :: (Eq a, Num a) => [a] -> [a]
> repeat' x 0 = []
> repeat' x n = x : (repeat' x (n-1))
> replicate' [a] = repeat' a a
> replicate' (h:t) = (repeat' h h) ++ (replicate' t)

