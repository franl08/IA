pertence(X, [X|_]).
pertence(X, [_|T]) :- pertence(X, T).

comprimento([], 0).
comprimento([_|T], R) :- comprimento(T, N), R is N + 1.

diferentes([], 0).
diferentes([H|T], R) :- pertence(H, T), diferentes(T, R).
diferentes([H|T], R) :- not(pertence(H, T)), diferentes(T, N), R is N + 1.

apaga1(_, [], []).
apaga1(X, [X|T], T).
apaga1(X, [H|T], [H|L]) :- X =\= H, apaga1(X, T, L).

apagaT(_, [], []).
apagaT(X, [X|T], L) :- apagaT(X, T, L).
apagaT(X, [H|T], [H|L]) :- X =\= H, apagaT(X, T, L).

adicionar(X, L, [X|L]) :- not(pertence(X, L)).
adicionar(X, L, L) :- pertence(X, L).

concatenar(L1, [], L1).
concatenar([], L2, L2).
concatenar([H|T], L2, [H|L1]) :- concatenar(T, L2, L1).

inverter([], []).
inverter([H|T], L3) :- inverter(T, L2), concatenar(L2, [H], L3).

prefixo([], _).
prefixo([H|L1], [H|L2]) :- sublista(L1, L2).

sublista(L1, L2) :- prefixo(L1, L2).
sublista(L1, [_|T]) :- sublista(L1, T).  
