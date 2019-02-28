insert(X, node(X,L,R), node(X,L,R)).
insert(X, node(Y,nil,R), node(Y,node(X,nil,nil),R)) :- X < Y.
insert(X, node(Y,L,nil), node(Y,L,node(X,nil,nil))) :- X > Y.
insert(X, node(Y,L,R), node(Y,L2,R)) :- X < Y, insert(X,L,L2).
insert(X, node(Y,L,R), node(Y,L,R2)) :- X > Y, insert(X,R,R2).

to_list(nil, []).
to_list(node(X,L,R), List) :- to_list(L,LL), to_list(R,RL), append(LL,[X|RL], List).

right_rotate(node(H, node(LH, LL, RL), R), node(LH, LL, node(H, RL, R))).

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

run(nn(X), X).
run(nu(Op, X), E) :- run(X, XX), F=.. [Op, XX], E is F.
run(nb(Op, L, R), E) :- run(L, LL), run(R, RL), F=.. [Op, LL, RL], E is F. 

binaryAP(nn(_),[]).
binaryAP(nu(_,Y), List) :- binaryAP(Y, List).
binaryAP(nb(X,L,R), List) :- binaryAP(L,LL), binaryAP(R, RL), append(LL, [X|RL], List).

unNest([], []).
unNest(X,[X]) :- atom(X).
unNest([H|T], List):- unNest(H, HL), unNest(T, TL), append(HL,TL,List).

append3DL(A-B, B-C, C-D, A-D).

my_max(X,Y,Y) :- X =< Y, !.
my_max(X,Y,X) :- X > Y.

my_max1(X,Y,Z) :- X =< Y, !, Y = Z.
my_max1(X,_,X).

coin(dollar, 100).
coin(half, 50).
coin(quarter, 25).
coin(dime,10).
coin(nickel,5).
coin(penny,1).
change(0, []).
change(X, [(AmntName, AmntCoins)|T]) :- coin(AmntName, Value), X >= Value, AmntCoins is div(X, Value), Left is mod(X, Value), change(Left, T).
