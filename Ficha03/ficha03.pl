pertence(X,[X|Y]).
pertence(X,[Y|Z]) :- X \= Y , pertence(X,Z).


comprimento([],0).
comprimento([_|L],N) :- comprimento(L, X) , N is X + 1.

diferentes([],0).
diferentes([X|L], N) :- pertence(X,L), diferentes(L, N).
diferentes([X|L], N) :- diferentes(L, AC), N is AC + 1.

apaga1(X,[],[]).
apaga1(X,[X|T],T).
apaga1(X,[Y|T],[Y|T1]) :- apaga1(X,T,T1).

apagaT(X,[],[]) :- !.
apagaT(X,[X|T],Y) :- !, apagaT(X,T,Y).
apagaT(X,[Y|T],Z) :!, apagaT(X,T,Z2),append([Y],Z2,Z).

adicionar(X,L,L) :- pertence(X,L).
adicionar(X,L,[X|L]) :- !.

concatenar([],L,L).
concatenar([X|L1],L2,[X|L3]) :- concatenar(L1,L2,L3).

inverter([],[]).
inverter([X],[X]).
inverter([[X|XS],R]) :- inverter(XS,T),append(T,[X],R).

sublist([],[]).
sublist([X|T],[X|T1]) :- sublist(T,T1).
sublist([_|T], T1) :- sublist(T,T1).