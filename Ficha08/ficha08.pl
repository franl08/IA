:- set_prolog_flag(discontiguous_warnings, off).
:- set_prolog_flag(single_var_warnings, off).
:- set_prolog_flag(unknown, fail).

:- op(900, xfy, '::').
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic idade/2.
:- dynamic avo/2.
:- dynamic neto/2.
:- dynamic descendente/3.

pai(P, F) :- filho(F, P).
avo(A, N) :- filho(X, A), filho(N, X).
avoDesc(A, N) :- descendente(A, N, 2).
neto(N, A) :- avo(A, N).
descendente(D, A, 1) :- filho(D, A).
descendente(D, A, Grau) :- filho(D, X), descendente(X, A, N), G is N + 1.

+filho(Filho, Pai)::(findall((Filho, Pai), filho(Filho, Pai), Lista), length(Lista, N), N == 0).
-filho(Filho, Pai)::(findall((Filho, Pai), filho(Filho, Pai), Lista), length(Lista, N), N == 1).

+pai(Pai, Filho)::(findall((Pai, Filho), pai(Pai, Filho), Lista), length(Lista, N), N == 0).
-pai(Pai, Filho)::(findall((Pai, Filho), pai(Pai, Filho), Lista), length(Lista, N), N == 1).

+neto(Neto, Avo)::(findall((Neto, Avo), neto(Neto, Avo), Lista), length(Lista, N), N == 0).
-neto(Neto, Avo)::(findall((Neto, Avo), neto(Neto, Avo), Lista), length(Lista, N), N == 1).

+avo(Avo, Neto)::(findall((Avo, Neto), avo(Avo, Neto), Lista), length(Lista, N), N == 0).
-avo(Avo, Neto)::(findall((Avo, Neto), avo(Avo, Neto), Lista), length(Lista, N), N == 1).

+descendente(Descendente, Pessoa, Grau)::(findall((Descendente, Pessoa, Grau), descendente(Descendente, Pessoa, Grau), Lista), length(Lista, N), N == 0).
-descendente(Descendente, Pessoa, Grau)::(findall((Descendente, Pessoa, Grau), descendente(Descendente, Pessoa, Grau), Lista), length(Lista, N), N == 1).

+filho(F, P)::(findall((F, P), filho(F, P), Lista), lentgh(Lista, N), N < 2).
-filho(F, P)::(findall((F, P), filho(F, P), Lista), lentgh(Lista, N), N > 0).

+pai(P, F)::(findall((P, F), pai(P, F), Lista), length(Lista, N), N < 2).
-pai(P, F)::(findall((P, F), pai(P, F), Lista), length(Lista, N), N > 0).

+neto(N, A)::(findall((N, A), neto(N, A), Lista), length(Lista, N), N < 4).
-neto(N, A)::(findall((N, A), neto(N, A), Lista), length(Lista, N), N > 0).

+avo(A, N)::(findall((A, N), avo(A, N), Lista), length(Lista, N), N < 4).
-avo(A, N)::(findall((A, N), avo(A, N), Lista), length(Lista, N), N > 0).

+descendente(Descendente, Pessoa, Grau)::integer(Grau), Grau > 0.

% Predicado de Evolução
evolucao(Termo) :- findall(Invariante, +Termo::Invariante, Lista), teste(Lista), insercao(Termo).
insercao(Termo) :- assert(Termo).

% Predicado de Involução
involucao(Termo) :- findall(Invariante, -Termo::Invariante, Lista), teste(Lista), remocao(Termo).
remocao(Termo) :- retract(Termo).

teste([]).
teste([R|RL]) :- R, teste(RL).