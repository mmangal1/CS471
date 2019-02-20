checkgoals([]).
checkgoals([H|T]) :- H, checkgoals(T).


computeS(Op, Arg1, Arg2, Result) :- E = .. [Op, Arg1, Arg2], Result is E.


result([], []).
result([H|T], [X|Y]) :- X is H, result([T], [Y]).


sumlist([], 0).
sumlist([H|T], X) :- sumlist(T, R), X is R + H.

 
sumlist2(List,Sum) :- sumlist2(List, 0, Sum).
sumlist2([], Sum, Sum).
sumlist2([H|T], P, _) :- S is P + H, sumlist2(T, S, S).


sumPartialR(1, [1]).
sumPartialR(_, [H1,H2|T]) :- N is H1-H2-1, sumPartialR(N, [H2|T]).


sumPartialL(N, Lst) :- sumPartialL(N, N, Lst).
sumPartialL(1, N, [N]).
sumPartialL(_, H1, [H1,H2|T]) :- N is H2-H1, sumPartialL(N, H2, [H2|T]).


outgoing(A, L) :- findall(X, edge(A, X), L).
incoming(A, L) :- findall(X, edge(X, A), L).


d(x,x,1) :- !.
d(C,x,0) :- number(C).
d(C*x, x, C) :- number(C).
d(-U, x, -R) :- d(U, x, R).
d(U+V, x, UR+VR) :- d(U,x,UR), d(V,x,VR).
d(U-V, x, UR-VR) :- d(U,x,UR), d(V,x,VR).
d(U*V, x, U*VR+V*UR) :- d(U,x,UR), d(V,x,VR).
d(U^N, x, N*U^Z*UR) :- d(U, x, UR), Z is N-1.


swap(leaf(X), leaf(X)).
swap(tree(X,Y), tree(A,B)) :- swap(X,B), swap(Y,A).

digitNum([], _A).
digitNum([H|T], A) :-
	select(H, A, X), digitNum(T, X).

soln([D, E, M, N, O, R, S, Y]) :- 
	Digits = [2,3,4,5,6,7,8,9],
	M is 1, O is 0, (S is 8; S is 9),
	digitNum([D,E,N,R,S,Y], Digits), N is E + 1,
	S * 1000 + E * 100 + N * 10 + D +
	M * 1000 + O * 100 + R * 10 + E =:=
	M * 10000 + O * 1000 + N * 100 + E * 10 + Y.



