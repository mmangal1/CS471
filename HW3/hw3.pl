/*
   Maitri Mangal
   CS 471 Assignment 3
*/

%Q3
my_member(X, [X|_]).
my_member(X, [_|Y]) :- my_member(X, Y).

%Q4
init([_], []).
init([X|Y], [X|Z]) :- init(Y,Z).

%Q5
is_decreasing([]).
is_decreasing([_]).
is_decreasing([X, Y|T]) :- X >= Y, is_decreasing([Y|T]).

%Q6
element_at(X, [X|_], 0).  
element_at(X, [_|T], N) :- Y is N - 1, element_at(X, T, Y).

%Q7
insert_at(X,P,0,[X|P]).
insert_at(X,[H|T],N,[H|Z]) :- Y is N-1, insert_at(X,T,Y,Z).

%Q8
delete_at(X,Y,N,Z) :- insert_at(X,Z,N,Y).

%Q9
zip([],[],[]).
zip([A|B],[C|D],[(A,C)|E]) :- zip(B,D,E).

%Q10
zip2([],[],[]).
zip2([_|_],[],[]).
zip2([],[_|_],[]).
zip2([A|B],[C|D],[(A,C)|E]) :- zip2(B,D,E).

%Q11
merge([],[],[]).
merge([],L,L).
merge(L,[],L).
merge([A|B],[C|D],[E|F]) :- A >= C, A = E, merge(B,[C|D],F);
                            C >= A, C = E, merge([A|B],D,F).

%Q12
greater_than(succ(_),0).
greater_than(succ(X), succ(Y)) :- greater_than(X,Y).

%Q13
add(0,Y,Y).
add(succ(X),Y,succ(Z)) :- add(X,Y,Z).
subtract(Num1, Num2, Result) :- add(Num2, Result, Num1).

%Q14
has_subseq([], []).
has_subseq([_|_], []).
has_subseq([X|T1], [X|T2]) :- has_subseq(T1, T2).
has_subseq([_|T1], [X|T2]) :- has_subseq(T1, [X|T2]).

%Q15
isBinaryTree(leaf(_)).
isBinaryTree(tree(L,R)) :- isBinaryTree(L), isBinaryTree(R).
