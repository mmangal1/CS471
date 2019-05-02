Maitri Mangal
CS471 Assignment 12

> module Hw12
>     where


Rename this file to "Hw12.lhs".
Add your code to this file in the positions indicated with "Problem N Answer:".
You will need to remove the spaces before ">" for the types to become part of
your code.

The names of the functions SHOULD NOT BE CHANGED. I will be grading these with
a script - if your code doesn't define the functions with the exact names
specified, they will be assumed skipped.

Once you've finished editing this file, submit it in a tar.gz directory
as usual.


Problem 1:

Write a function "prodAll" that takes a list of numbers and returns their sum.
This must be a recursive solution.
Example:
...> prodALL [2,7,4]
56

Problem 1 Answer:

> prodALL :: Num a => [a] -> a
> prodALL [] = 1
> prodALL (num:list) = num * (prodALL list)


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
> binOpALL op [num] = num
> binOpALL op lst = op (binOpALL op (init lst)) (last lst)

Problem 3:  Write a function prodALLC that behaves like prodALL (problem 1)
            Your definition must use a partial evaluation of  binOpALL .
   

Example:
...> prodALLC [2,7,4]
56

Problem 3 Answer:

> prodALLC lst = binOpALL (*) lst


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
> insertAt v p [] = [v]
> insertAt v p (x:y)
> 	   | p == 0 	= [v,x] ++ y
>	   | otherwise	= [x] ++ (insertAt v (p-1) y)


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

> composeList [n] = n
> composeList (x:y) = x.composeList(y)

Problem 6:
In homework 1 you were introduced to the Ackermann Numbers.
The definition we used in the assignment is:

ack( m,n ) =n + 1    if m = 0
ack( m,n ) =ack(m - 1, 1)    if n = 0 and m > 0 
ack( m,n ) =ack( m-1, ack( m, n-1 ) )   if n >0 and m > 0

Define the ack function in Haskell.
Example:
...> ack 0 3
4
...> ack 3 2
29

Problem 6 Answer:

> ack m n
>	| m == 0		= n + 1
>	| n == 0 && m > 0 	= ack (m - 1) 1
>	| n > 0  && m > 0	= ack (m - 1) (ack m (n - 1)) 


Problem 7: 
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

Problem 7 Answer:
Note: again, you may have a slightly different type depending on your
solution.


> newtonAppr :: (Fractional a, Ord a) => a -> a -> a -> a
> quotient num_x num_y = (num_x/num_y)
> newGuess num guess = quotient ((quotient num guess) + guess) 2
> newtonAppr square guess nearEnough
>		| actual <= nearEnough	= guess
>		| otherwise		= newtonAppr square (newGuess square guess) nearEnough
>		where actual 		= (abs ((guess * guess) - square))
