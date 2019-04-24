Maitri Mangal
CS471 Assignment 11

> module Hw11
> where

----------------------------------------------------------
Problem 2
----------------------------------------------------------
Define factorial. Let Haskell infer the type of factorial.

> factorial n = if n == 0 then 1 else n * factorial (n-1)

Difference between if expression and if statement is that expression produces a result or a value, and thus can be assigned wherever the value is needed. An if statememnt only evaluates the statemetnts given and goes onto the code in which it evaluates the statement to be true

factorial 5 gives us 120
Type of factorial - factorial :: (Num t, Eq t) => t -> t


----------------------------------------------------------
Problem 3
----------------------------------------------------------

> fact1 :: Int -> Int
> fact1 n = if n == 0 then 1 else n * fact1 (n-1)
> fact2 :: Integer -> Integer
> fact2 n = if n == 0 then 1 else n * fact2 (n-1)



----------------------------------------------------------
Problem 4
----------------------------------------------------------

factorial 12 - 479001600
fact1 12 - 479001600
fact2 12 - 479001600
factorial 13 - 6227020800
fact1 13 - 6227020800
fact2 13 - 6227020800
factorial 500 -  6227020800
fact1 13 - 6227020800
fact2 13 - 6227020800
factorial 500 - 1220136825991110068701238785423046926253574342803192842192413588385845373153881997605496447502203281863013616477148203584163378722078177200480785205159329285477907571939330603772960859086270429174547882424912726344305670173270769461062802310452644218878789465754777149863494367781037644274033827365397471386477878495438489595537537990423241061271326984327745715546309977202781014561081188373709531016356324432987029563896628911658974769572087926928871281780070265174507768410719624390394322536422605234945850129918571501248706961568141625359056693423813008856249246891564126775654481886506593847951775360894005745238940335798476363944905313062323749066445048824665075946735862074637925184200459369692981022263971952597190945217823331756934581508552332820762820023402626907898342451712006207714640979456116127629145951237229913340169552363850942885592018727433795173014586357570828355780158735432768888680120399882384702151467605445407663535984174430480128938313896881639487469658817504506926365338175055478128640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fact1 500 - 0
fact2 500 - 1220136825991110068701238785423046926253574342803192842192413588385845373153881997605496447502203281863013616477148203584163378722078177200480785205159329285477907571939330603772960859086270429174547882424912726344305670173270769461062802310452644218878789465754777149863494367781037644274033827365397471386477878495438489595537537990423241061271326984327745715546309977202781014561081188373709531016356324432987029563896628911658974769572087926928871281780070265174507768410719624390394322536422605234945850129918571501248706961568141625359056693423813008856249246891564126775654481886506593847951775360894005745238940335798476363944905313062323749066445048824665075946735862074637925184200459369692981022263971952597190945217823331756934581508552332820762820023402626907898342451712006207714640979456116127629145951237229913340169552363850942885592018727433795173014586357570828355780158735432768888680120399882384702151467605445407663535984174430480128938313896881639487469658817504506926365338175055478128640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

fact1 uses int which is a bounded number, it has a minimum and maximum bound and hence cannot represent really big numbers. Hence, fact1 prints out 0. On the other hand fact2 uses Integer. Integer is not bounded, and hence can represent really really big numbers. For Int usually the maximum number it can represnet is 2147483647.


----------------------------------------------------------
Problem 5
----------------------------------------------------------
:t fact1 - fact1 :: Int -> Int
:t fact1 5 - fact1 5 :: Int
:t (*) - (*) :: Num a => a -> a -> a
:t (==) - (==) :: Eq a => a -> a -> Bool
:t 5 - 5 :: Num t => t 
:t 5.1 - 5.1 :: Fractional t => t
:t 5::Int - 5::Int :: Int
:t factorial - factorial :: (Num t, Eq t) => t -> t 
:t factorial 5 - factorial 5 :: (Num t, Eq t) => t
:t (-) - (-) :: Num a => a -> a -> a
:t (2-) - (2-) :: Num a => a -> a 
:t (-) 2 - (-) 2 :: Num a => a -> a 
:t error - error :: [Char] -> a
:t (2 - ) --Currying - (2 - ) :: Num a => a -> a

factorial (-2) - *** Exception: stack overflow
This gives us an exception because the recursion is going to keep happening without ever hitting the base case as (-2)-1 and onwards will never hit 0. Thus, the stack over flows.

factorial -2 -- gives us an error 
This is due to the fact that haskell interprets -2 as not a Num. Thus, when we try to pass it into facotrial it complains that the type required for the parameter does not match what is provided by -2 

----------------------------------------------------------
Problem 6
----------------------------------------------------------

> factP :: Integer -> Integer
> factP 0 = 1
> factP n = n * factP(n -1)

factP 12 - 479001600
factP 13 - 6227020800
factP 500 - 1220136825991110068701238785423046926253574342803192842192413588385845373153881997605496447502203281863013616477148203584163378722078177200480785205159329285477907571939330603772960859086270429174547882424912726344305670173270769461062802310452644218878789465754777149863494367781037644274033827365397471386477878495438489595537537990423241061271326984327745715546309977202781014561081188373709531016356324432987029563896628911658974769572087926928871281780070265174507768410719624390394322536422605234945850129918571501248706961568141625359056693423813008856249246891564126775654481886506593847951775360894005745238940335798476363944905313062323749066445048824665075946735862074637925184200459369692981022263971952597190945217823331756934581508552332820762820023402626907898342451712006207714640979456116127629145951237229913340169552363850942885592018727433795173014586357570828355780158735432768888680120399882384702151467605445407663535984174430480128938313896881639487469658817504506926365338175055478128640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

----------------------------------------------------------
Problem 7
----------------------------------------------------------

> factG x
>     | x < 0     = error "neg x"
>     | x == 0    = 1
>     | otherwise = x*factG(x-1)

There are 3 definitions. One for number being negative, one being equal to zero, and the other if greater than 0. When we try factG (-2), then this prints out our exception message of the number being negative -- neg x, and then the program terminates.

----------------------------------------------------------
Problem 8
----------------------------------------------------------

> factG2 :: Integer -> Integer
> factG2 n
>     | n < 0     = error "neg n"
>     | n == 0    = 1
>     | otherwise = n * factG2 (n - 1)
> factE :: Integer -> Integer
> factE n
>     | n < 0     = error "neg n"
>     | n == 0    = 1
>     | otherwise = n * factE n - 1


factorial 5.1 - gives us that the stack has overflowed because as a decimal number, n will never hit 0, and hence it will keep doing recursion until the stack has filled up
factG 5.1 - gives us the error that the 5.1 is neg x. This might happen because it goes into the otherwise statemtn for the first 5 times, and then when the number turns negative it throws out the error neg n message
factG2 5.1 - recognizes that 5.1 is not an Integer. Hence it throws out the message sayign that there is no instance for a fractional Integer. This means that it expected an integer, and since 5.1 is not an integer, it could not carryout the factG2 function.
factG2 5 - 120, prints out nicely as the number eventually turn 0 and the base case is reached
factE 5 - gives us a stack overflow, this might be due to the fact that there is no paranthesis around n-1, hence when factE is recusrively called it only takes in n and keeps multiplying n to itself, leading to an overflow of the stack because it never reaches the base case. 
