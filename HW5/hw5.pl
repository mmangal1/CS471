/* Homework Assignment 5
   Programming Languages
   CS471, Spring 19
   Binghamton University */

/* Instructions */

/* This section deals with general submission instructions. 
   First, grab this assignment's  source file. BEFORE MOVING ON RENAME 
   hw5S18.asn to username_hw5.pl. You will be able to code in and run the file 
   in the prolog interpreter directly. I recommend reading this assignment 
   directly from the source file.

We will be using swipl for our prolog environment: 
To load/reload this file, cd to its directory and run swipl. 
Then, in the prompt, type [hw5].

     cd PATH_TO_FILE
     swipl
     [hw5].

From then on you may execute queries (goals) in the prompt. As usual, you should provide your answers in the designated spot. Once you have added some code to the file, rerun [hw5]. in the swipl prompt to reload.

In addition, there are unit tests for each problem. These are there to help you better understand what the question asks for, as well as check your code. They are included in our "database" as queries and are initially commented out -- % is a Prolog line comment.

%:- member_times(4,[3,3,2,3],0). % SUCCEED
%:- member_times(4,[1,2,3],3).   % FAIL

After you have finished a problem and are ready to test, remove the initial % for each test for the associated problem and reload the assignment file ([hw5].). Each SUCCEED line should silently load and succeed, and each FAIL line should throw a WARNING. If a SUCCEED line throws a WARNING, or a FAIL line fails to, then you solution is not correct. If you pass the tests there is a good chance that your code is correct, but not guaranteed; the tests are meant as guided feedback and are not a check for 100% correctness. */

/* Submission */

/* For this assignment -- and the remaining Prolog assignments -- you must submit only the source (template) file. /*Please store hw3.pl within a tarball named username_hw5.tar.gz  */

/* Homework 5 */

/* Due: Next Wed, 11:59 PM */

/* Purpose: To get comfortable with unification and pattern matching. 
   Use */



/* Problem 1:
In class we discussed that we can encode a binary search tree in Prolog using complex terms: i.e, the following BST

        5
       / \
      3   7
     / \
    1   4

can be encoded as node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)).

Write a predicate insert(X,Y,Z) that succeeds if Z is the tree Y with X inserted (insert X into Y). You may assume you have a binary search tree. */

/* Problem 1 Answer: */

insert(X, node(X,L,R), node(X,L,R)).
insert(X, node(Y,nil,R), node(Y,node(X,nil,nil),R)) :- X < Y.
insert(X, node(Y,L,nil), node(Y,L,node(X,nil,nil))) :- X > Y.
insert(X, node(Y,L,R), node(Y,L2,R)) :- X < Y, insert(X,L,L2).
insert(X, node(Y,L,R), node(Y,L,R2)) :- X > Y, insert(X,R,R2).

/* Problem 1 Test: */

% :- insert(3,node(5,nil,nil),X), X = node(5,node(3,nil,nil),nil). %SUCCEED
% :- insert(7,node(5,nil,nil),X), X = node(5,nil,node(7,nil,nil)).  %SUCCEED
% :- insert(1,node(5,node(3,nil,nil),node(7,nil,nil)),X), X = node(5,node(3,node(1,nil,nil),nil),node(7,nil,nil)). %SUCCEED
% :- insert(1,node(5,node(3,node(2,nil,nil),nil),node(7,nil,nil)),X), X = node(5,node(3,node(2,node(1,nil,nil),nil),nil),node(7,nil,nil)). %SUCCEED

% :- (insert(3,node(5,node(3,node(2,nil,nil),nil),node(7,nil,nil)),X), X = node(5,node(3,node(2,node(3,nil,nil),nil)),node(7,nil,nil))) -> fail ; true.


/* Problem 2:
Using the same encoding for a binary search tree, write a predicate to_list(X,Y) that succeeds if Y is an in-order list of the elements of all the nodes of tree X (Y should show an in order traversal of X). If you are rusty and do not remember what an in order traversal is, give https://en.wikipedia.org/wiki/Tree_traversal#In-order a quick glance.

For example...
to_list(node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)),X) will succeed with X = [1,3,4,5,7]. */

/* Problem 2 Answer:  */

to_list(nil, []).
to_list(node(X,L,R), List) :- to_list(L,LL), to_list(R,RL), append(LL,[X|RL], List).

/* Problem 2 Tests:  */
%:- to_list(node(3,nil,nil),L), L = [3]. %SUCCEED
%:- to_list(node(5,node(3,nil,nil),nil),L), L = [3,5].  %SUCCEED
%:- to_list(node(5,node(3,node(1,nil,nil),node(4,nil,nil)),node(7,nil,nil)),L), L = [1,3,4,5,7]. %SUCCEED

%:- (to_list(node(3,nil,nil),L), L = [5]) -> fail ; true.


/* Problem 3:
Write a predicate right_rotate(X,Y) that succeeds if Y is the tree X rotated right at its root. Read https://en.wikipedia.org/wiki/Tree_rotation to refresh tree rotation in full. This problem may seem hard at first, but once you "see" the answer it really demonstrates the elegance of unification/pattern matching. You do not need to handle error cases.

For example, the following shows a right rotation at the root.

        5                        3
       / \                      / \
      3   7         -->        2   5
     / \                          / \
    2   4                        4   7

*/

/* Problem 3 Answer: */

right_rotate(node(H, node(LH, LL, RL), R), node(LH, LL, node(H, RL, R))).

/* Problem 3 Test: */
%:- right_rotate(node(5,node(3,node(2,nil,nil),node(4,nil,nil)),node(7,nil,nil)),X), X = node(3, node(2, nil, nil), node(5, node(4, nil, nil), node(7, nil, nil))). %SUCCEED
%:- right_rotate(node(5,node(3,nil,node(4,nil,nil)),node(7,nil,nil)),X), X = node(3, nil, node(5, node(4, nil, nil), node(7, nil, nil))). %SUCCEED
%:- right_rotate(node(3,node(2,node(1,nil,nil),nil),nil),X), right_rotate(X,Y), Y = node(1,nil,node(2,nil,node(3,nil,nil))). %SUCCEED

%:- right_rotate(node(5,nil,node(7,nil,nil)),_) -> fail ; true. %FAIL


/* Problem 4:

 In the assignment 4, you wrote Prolog rules for symbolic differentiation.
 Below is my solutions for this problem.
 Keep in mind, though, that terms such as U+V are still trees with the functor
 at the root, and that evaluation of such terms requires additional processing
 which you will complete.

 Define the predicate, 'evaluate'/3, that uses the result from symbolic
 differentiation  and a list of items with the structure var:value (e.g. [a:5,x:6]
 and computes the resulting value. e.g.

    ?- d(3*(x +2*x*x),x,Result), VarValue = [x:2,y:5], evaluate(Result,Value,VarValue).
    Result = 3* (1+ (2*x*1+x*2))+ (x+2*x*x)*0,
    VarValue = [x:2, y:5],
    Value = 27


    ?- d((3*x) ^ 4,x,Result), VarValue = [x:2,y:5] , evaluate(Result,Value,VarValue).
    Result = 4* (3*x)^3*3,
    VarValue = [x:2, y:5],
    Value = 2592.


 */

/* Problem 4 Answer:  */

d(x,x,1).
d(C,x,0):-number(C).
d(C*x,x,C):-number(C).
d(-U, X, -DU) :- d(U, X, DU).
d( U + V, x, RU + RV ):-d(U,x,RU), d(V,x,RV).
d( U - V, x, RU - RV ):-d(U,x,RU), d(V,x,RV).
d(U * V,x, U * DV + V * DU):- d(U,x,DU), d(V,x,DV).
d(U ^ N, x, N*U ^ N1*DU) :- integer(N), N1 is N-1, d(U, x, DU).

evaluate(N, N, _) :- number(N).
evaluate(Atom, N, List) :- atom(Atom), !, member(Atom:N, List).
evaluate(U+V, N, List) :- evaluate(U, UN, List), evaluate(V, VN, List), N is UN + VN.
evaluate(U-V, N, List) :- evaluate(U, UN, List), evaluate(V, VN, List), N is UN - VN.
evaluate(U*V, N, List) :- evaluate(U, UN, List), evaluate(V, VN, List), N is UN * VN.
evaluate(U^Exp, N, List) :- evaluate(U, UN, List), number(Exp), N is UN ^ Exp.

/* Problem 4 Tests:  */
% :- evaluate(x*y, 6, [x:2, y:3]).
% :- evaluate(x*y, 8, [x:2, y:3]) -> fail ; true.
% :- evaluate(x^3, 8, [x:2]).
% :- evaluate(2*8, 16, []).
% :- evaluate(2*8, 0, []) -> fail ; true.
% :- evaluate(2*y, 16, [y:8]).

% :- d(3*(x +2*x*x),x,Result), VarValue = [x:2,y:5], evaluate(Result,Value,VarValue),
%     Result = 3* (1+ (2*x*1+x*2))+ (x+2*x*x)*0,
%     VarValue = [x:2, y:5],
%     Value = 27.

% :- d((3*x) ^ 4,x,Result), VarValue = [x:2,y:5] , evaluate(Result,Value,VarValue),
%     Result = 4* (3*x)^3*3,
%     VarValue = [x:2, y:5],
%     Result = 4* (3*x)^3*3,
%     VarValue = [x:2, y:5],
%     Value = 2592.


/* Problem 5:
We will encode a mini-AST in Prolog using complex data structures. A "node" will consist of either a nb(Functor,LeftExpr,RightExpr), nu(Functor,Expr) or nn(Number).

nb(Functor,LeftExpr,RightExpr) -- "node binary", Functor is guaranteed to be a binary arithmetic predicate that can be evaluated with `is`. LeftExpr and RightExpr are recursively defined "nodes".

nu(Functor,Expr) -- "node unary", Functor is guaranteed to be a unary arithmetic predicate that can be evaluated with `is`. Expr is a recursively defined "node".

nn(Number) -- "node number", Number is guaranteed to be just that.

Hence, the following AST
      +
     / \
    *   random
   / \       \
  2  3        5
would be encoded as nb(+,nb(*,nn(2),nn(3)),nu(random,nn(5))).

Write a predicate run(X,Y) that succeeds if Y is the result obtained from "running" (evaluating) X. You will need to use the =.. predicate. It may be helped to view some of the binary and unary arithmetic predicates -- http://www.swi-prolog.org/man/Ardith.html. If you write your predicate correctly, you do not need to concern yourself with the actual arithmetic functor supplied in the nodes. */

/* Problem 5 Answer: */

run(nn(X), X).
run(nu(Op, X), E) :- run(X, XX), F=.. [Op, XX], E is F.
run(nb(Op, L, R), E) :- run(L, LL), run(R, RL), F=.. [Op, LL, RL], E is F. 

/* Problem 5 Tests: */
%:- run(nb(+,nb(*,nn(2),nn(3)),nu(random,nn(5))),_).
%:- run(nb(+,nb(*,nn(2),nn(3)),nn(3)),E), E=9.
%:- run(nb(+,nb(*,nn(2),nn(3)),nb(-,nn(6),nn(3))),E), E=9.
%:- run(nn(2),E), E=2.
%:- run(nu(abs,nn(-2)),E), E=2.

%:- (run(nb(+,nb(*,nn(2),nn(3)),nb(-,nn(6),nn(3))),E), E=8) -> fail ; true.


/* Problem 6:
Using the AST described in problem 5, write a predicate binaryAP/2.  binaryAP(AST, BPlst) succeeds if all the binary arithmetic predicates that occur in AST are collected into BPlst.  Use an in order traversal of AST.  */

/* Problem 6 Answer: */

binaryAP(nn(_),[]).
binaryAP(nu(_,Y), List) :- binaryAP(Y, List).
binaryAP(nb(X,L,R), List) :- binaryAP(L,LL), binaryAP(R, RL), append(LL, [X|RL], List).

/* Problem 6 Tests: */
%:- T = nb(+,nb(*,nn(2),nn(3)),nu(random,nn(5))), binaryAP(T,L), L = [*, +].  %SUCCEED
%:- T = nb(+, nb(*, nn(2), nn(3)), nb(-,nn(3), nn(5))),  binaryAP(T,L), L = [*, +, -]. %SUCCEED
%:- T = nb(+, nb(*, nn(2),  nb(-,nn(3), nb(//, nn(2), nn(5)))),nn(9)) ,  binaryAP(T,L), L = [*, -, //, +]. %SUCCEED

%:- (T = nb(+,nb(*,nn(2),nn(3)),nu(random,nn(5))), binaryAP(T,L), L = [+,*]) -> fail ; true.



/* Problem 7:
   Write a predicate unNest/2.  unNest(+Nested, -LstAtoms), where Nested is a list of
   lists of atoms and LstAtoms is a list of atoms (i.e. no items in LstAtoms is a list), 
   succeeds if all the atoms from Nested are in LstAtoms and in the same order.
   For example, unNest([a,[b,[c]],d],U) succeeds if U = [a, b, c, d] .


   Think What NOT how. This can be done with only 3 clauses */

/* Problem 7 Answer: */

unNest([], []).
unNest(X,[X]) :- atom(X).
unNest([H|T], List):- unNest(H, HL), unNest(T, TL), append(HL,TL,List).

/* Problem 7 Tests: */

% :- unNest([[r,s,[x,y]],[a],[],[s,t]],One), One = [r, s, x, y, a, s, t]. %succeeds
% :- unNest([[r,s,[x,y]],[a],[],[s,t]],One), One = [r, s, x, y, a, t] -> fail ; true. 
% :- unNest([[[r]],[]],[r]). %succeeds


/* Problem 8:

In class we discussed difference lists and how to append two of them in "constant" time.

Write a predicate, append3DL(A,B,C,D) that succeeds if D is the difference lists A, B, and C appended.
*/

/* Problem 8 Answer: */

append3DL(A-B, B-C, C-D, A-D).

/* Problem 8 Tests: */
%:- append3DL([1,2|A]-A,[3,4|B]-B,[5,6|[]]-[],L), L = [1,2,3,4,5,6]-[]. % SUCCEED
%:- append3DL([a,b|A]-A,[b,1,2|B]-B,[3|C]-C,L), L = [a, b, b, 1, 2, 3|C]-C. % SUCCEED

%:- (append3DL([1,2|A]-A,[3,4|B]-B,[5,6|[]]-[],L), L = [1,2,3,4,5]-[]) -> fail ; true.   % FAIL



/* Problem 9:
   In class we discussed green and red cuts (!). A green cut is a cut that DOES
   NOT change correctness (the answer returned) but simply improves efficiency
   by preventing unnecessary backtracking. Red cuts change correctness - if a
   predicate is correct and contains a cut that, when removed, is no longer
   correct, it is a red cut.

   Insert cuts into the following 2 predicates. The my_max/3 are already correct, 
   but using a cut (green) will improve their efficiency. 
   The last, my_max1/3 is wrong, but inserting a cut (red) will
   make it correct.
*/

/* Problem 9 Answer */


my_max(X,Y,Y) :- X =< Y, !.
my_max(X,Y,X) :- X > Y.

my_max1(X,Y,Z) :- X =< Y, !, Y = Z.
my_max1(X,_,X).

/* Problem 9 Test */
% You're own your own for this one :) */



/* Problem 10:

Write a predicate change/2 that given the change amount, computes the way in which exact change can be given. Use the following USA's coin facts at your solution. */

coin(dollar, 100).
coin(half, 50).
coin(quarter, 25).
coin(dime,10).
coin(nickel,5).
coin(penny,1).

/* The predicate change(S,CL) succeeds if given a positive integer S, CL is a list of tuples that contains the name of the coin and the number of coins needed to return the correct change.

The Coin Changing problem is an interesting problem usually studied in Algorithms.
http://condor.depaul.edu/~rjohnson/algorithm/coins.pdf is a nice discussion.
Think about (no need to turn in)
   1) How could we generalize this problem to handle coins from other currencies?
   2) What are the different techniques to find the change with the fewest number of coins ?
   3) What happens if the order of the "coin" facts change?  
   */

/* Problem 10 Answer: */

change(0, []).
change(X, [(AmntName, AmntCoins)|T]) :- coin(AmntName, Value), X >= Value, AmntCoins is div(X, Value), Left is mod(X, Value), change(Left, T).

/* Problem 10 Tests: */
%:- change(168,C), C = [ (dollar, 1), (half, 1), (dime, 1), (nickel, 1), (penny, 3)] .  %SUCCEED
%:- change(75,C),  C = [ (half, 1), (quarter, 1)] .                                     %SUCCEED

%:- (change(75,C), C = [(half, 2)]) -> fail ; true.             %FAIL


