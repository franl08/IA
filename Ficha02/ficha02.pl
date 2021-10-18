soma(X,Y,Result) :- Result is X + Y.
soma(X,Y,Z,Result) :- Result is X + Y + Z.

op(X,Y,+,Result) :- Result is X + Y.
op(X,Y,-,Result) :- Result is X - Y.
op(X,Y,*,Result) :- Result is X * Y.
op(X,Y,/,Result) :- Result is X / Y.

max(X,Y,Maximo) :- Maximo is max(X,Y).
max(X,Y,Z,Maximo) :- Maximo is max(max(X,Y),Z).

min(X,Y,Minimo) :- Minimo is min(X,Y).
min(X,Y,Z,Minimo) :- Minimo is min(min(X,Y),Z).

pares(X) :- mod(X,2) =:= 0.

% outra maneira:
% par(0).
% par(X) :- N is X >= 2, N >= 0, par(N).

impares(X) :- mod(X,2) =\= 0.

mdc(X,Y,D) :- X > Y, X1 is X - Y, mdc(X1,Y,D).
mdc(X,Y,D) :- X < Y, Y1 is Y - X, mdc(X,Y1,D).
mdc(X,X,X).

mmc(X,X,X).
mmc(X,Y,D) :- X < Y, Y1 is Y - X, mmc(X,Y1,D).
mmc(X,Y,D) :- X > Y, mmc(Y,X,D).
mmc(X,Y,D) :- mmc(X,Y,MDC), D is X * Y / MDC.