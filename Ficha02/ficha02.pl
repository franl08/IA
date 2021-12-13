soma(X, Y, R) :- R is X + Y.
soma(X, Y, Z, R) :- R is X + Y + Z.

op(X, Y, +, R) :- R is X + Y.
op(X, Y, -, R) :- R is X - Y.
op(X, Y, *, R) :- R is X * Y.
op(X, Y, /, R) :- R is X / Y.

maxValue(X, Y, R) :- X > Y -> R is X ; R is Y.
maxValue(X, Y, Z, R) :- maxValue(X, Y, N), maxValue(N, Z, R).

minValue(X, Y, R) :- X < Y -> R is Y ; R is X.
minValue(X, Y, Z, R) :- minValue(X, Y, N), minValue(N, Z, R).

par(X) :- mod(X,2) =:= 0.

impar(X) :- mod(X,2) =\= 0.

mdc(X, X, X).
mdc(X, Y, MDC) :- X < Y, R is Y - X, mdc(X, R, MDC).
mdc(X, Y, MDC) :- X > Y, mdc(Y, X, MDC).

mmc(X, Y, MMC) :- mdc(X, Y, MDC), MMC is X * Y / MDC.



