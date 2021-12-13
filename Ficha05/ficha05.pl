% -> Problema de Estado Único (O agente "sabe" exatamente o estado em que está. A solução é uma sequência.)

% Par(A, B) -> jarros(A, B)
% Estado inicial -> jarros(0, 0)
% Estado objetivo -> jarros(_, 4) ; jarros(4, _)
% Estado inicial <-> Estado objetivo -> Operadores

estadoInicial(jarros(0, 0)).

estadoFinal(jarros(_, 4)).
estadoFinal(jarros(4, _)).

depthFirst(EstIni, EstFin, Res) :- depthFirstAux(EstIni, EstFin, [], Res).

depthFirstAux(EstIni, EstIni, Vis, Res) :- reverse([Ei|Vis], Res).
depthFirstAux(EstIni, EstFin, Vis, Res) :- not(member(EstIni, Vis)), transicao(EstIni, T, E), depthFirstAux(E, EstFin, [EstIni|Vis], Res).

breadthFirst(EstIni, EstFin, Res) :- breadthFirstAux(Dest, [[EstIni]], Res).

breadthFirstAux(EstFin, [[EstFin|T]|_], Res) :- reverse([Dest|T], Res).
breadthFirstAux(EstFin, [LA|Outros], Res) :- LA=[Act|_],
                                            findall([X|LA], (transicao(Act, T, X), \+ member(X, LA)), Novos),
                                            append(Outros, Novos, Todos),
                                            breadthFirstAux(EstFin, Todos, Res).

% Operadores

% Encher A
transicao(jarros(A, B), encher(1), jarros(8, B)) :- A < 8.

% Encher B
transicao(jarros(A, B), encher(2), jarros(A, 5)) :- B < 8.

% Esvaziar A
transicao(jarros(A, B), esvaziar(1), jarros(0, B)) :- A > 0.

% Esvaziar B
transicao(jarros(A, B), esvaziar(2), jarros(A, 0)) :- B > 0.

% Transferir de A para B
transicao(jarros(A, B), transferir(1, 2), jarros(Af, Bf)) :-
    A > 0,
    Af is max(B - 5 + A, 0),
    Af < A,
    Bf is B + A - Af.

% Transferir de B para A
transicao(jarros(A, B), transferir(2, 1), jarros(Af, Bf)) :-
    B > 0,
    Bf is max(A - 5 + B, 0),
    Bf < B,
    Af is A + B - Bf.