> module HW12Lab1
> where

Tuple Data type

> prodT (a,b,c) = a * b * c

prodT(2,3,4) = 24
prodT(2,-3,4) = -24
:t prodT Num a => (a,a,a) -> a

Curried Functions

> prodC a b c = a * b * c

prodC 2 3 4 = 24
:t prodC Num a => a -> a -> a -> a

> prodCx :: Num a => a -> (a -> (a->a))
> prodCx a b c = a * b * c

prodCx 2 3 4 = 24 
:t prodCx Num a => a -> a -> a -> a
The type of prodCx and prodC are the same

> prodC1  = prodC 1
> prodC2  = prodC1 2
> prodC3  = prodC2 3
> prodC12 = prodC 1 2

:t prodC1 Integer -> Integer -> Integer
:t prodC2 Integer -> Integer
:t prodC3 Integer
:t prodC12 Integer -> Integer

 prodT1 = prodT 1 
 prodT2 = prodT(1) 
 prodT4 = prodT(1,2)
 prodT3 = prodT(1,x,y)

There are illegal statements as the prodT definition requires a tuple, and hence you cannot give partial definitions. Tuples require you to have the exact number of arguments

F G H = (F G) H

h(x) = 3 - ((x-1) * 2) * 5)
h2(x) = ((3 - (x * 5)) - 1) * 2)
h(2) = -7
h2(2) = -16

> f x =  3 - (x * 5)
> g x = (x -1) * 2

> h = f . g
> h2 = g . f

(A) Num a => a -> a -> a Takes 2 arguments and returns a value
(B) Num a => a -> (a -> a) Takes 2 arguuments and returns a value
(D) Eq a => a -> a -> Bool Takes 2 arguments and returns whether both of the argumenst are equal (true or false)
(E) (a -> b) -> [a] -> [b] Takes 2 arguments, one function and one list, and returns the list of the functions return value
(F) (a -> b -> a) -> a -> [b] -> a Takes 3 arguments, the first argument is a function, second a vaue, and third a list, and returns a value
(G) (a -> a) -> a -> a Takes 2 arguments, first a function, and then a value, and returns a value
(H) (b -> c) -> (a -> b) -> a -> c Takes 3 arguments, first two are functions, then an arguments, and then returns a value
(I) (a -> Bool) -> [a] -> [a] Takes 2 arguments, first function takes a value and returns a bool, the second arg is a list, and returns a list


