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
impares(X) :- mod(X,2) =\= 0.

%mdc(X,X,Result) :- Result is X.
%mdc(X,Y,Result) :- X > Y, mdc(Z,Y,Result), Z is X - Y.
%mdc(X,Y,Result) :- X < Y, mdc(X,Z,Result), Z is Y - X.

%mmc(X,Y,Result) :- X > Y, mod(Result,Y) =:= 0, Result is Result.
%mmc(X,Y,Result) :- X < Y, mod(Result,X) =:= 0, Result is Result.
%mmc(X,Y,Result) :- X < Y, mod(Result,X) =\= 0, mmc(X,Y,N), N is Y + Result.
%mmc(X,Y,Result) :- X > Y, mod(Result,Y) =\= 0, mmc(X,Y,N), N is X + Result.