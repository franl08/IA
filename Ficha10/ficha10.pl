:- op(500, xfy, '::').
:- dynamic '+'/1.
:- dynamic jogo/3.
:- discontiguous jogo/3.

-jogo(IdJogo, Arbitro, AC) :-
    not(jogo(IdJogo, Arbitro, AC)),
    not(excecao(jogo(IdJogo, Arbitro, AC))).

% Pergunta 1
% Conhecimento Perfeito
jogo(1, almeida_antunes, 500).

% Pergunta 2
% Conhecimento Imperfeito -> Conhecimento Incerto
jogo(2, baltazar_borges, valor_incerto).
excecao(jogo(IdJogo, Arbitro, AC)) :- jogo(IdJogo, Arbitro, valor_incerto).

% Pergunta 3
% Conhecimento Imperfeito -> Conhecimento Impreciso
excecao(jogo(3, costa_carvalho, 500)).
excecao(jogo(3, costa_carvalho, 2500)).

% Pergunta 4
% Conhecimento Imperfeito -> Conhecimento Impreciso
excecao(jogo(4, duarte_durao, AC)) :- AC >= 250 ; AC =< 750.

% Pergunta 5
% Conhecimento Imperfeito -> Conhecimento Interdito
jogo(5, edgar_esteves, valor_interdito).
excecao(jogo(IdJogo, Arbitro, AC)) :- jogo(IdJogo, Arbitro, valor_interdito).

% Pergunta 6
% Conhecimento Imperfeito -> Conhecimento Impreciso
jogo(6, francisco_franca, 250).
excecao(jogo(6, francisco_franca, AC)) :- AC =< 5000.

% Pergunta 7
% Conhecimento Imperfeito -> Conhecimento Interdito
-jogo(7, guerra_godinho, 2500).
jogo(7, guerra_godinho, valor).
excecao(jogo, IdJogo, Ac) :- jogo(IdJogo, Arbitro, valor).

% Pergunta 8
% Conhecimento Imperfeito -> Conhecimento Impreciso
excecao(jogo(8, helder_heitor, AC)) :- AC >= 1000 - 1000 * 0.5 , AC =< 1000 + 1000 * 0.5.

% Pergunta 9
% Conhecimento Imperfeito -> Conhecimento Impreciso
excecao(jogo(9, ivo_inocencio, AC)) :- AC >= 1000 - 1000 * 0.1 , AC =< 1000 + 1000 * 0.1.

% Predicados para conhecimento interdito
nulo(valor).
+jogo(IdJogo, Arbitro, Ac)::(findall(Ac, (jogo(IdJogo, Arbitro, Ac), not(nulo(Ac), L))), length(L, N), N == 0).

% Pergunta 10
+jogo(IdJogo, Arbitro, Ajudas)::(findall(Arbitro, jogo(IdJogo, Arbitro, _), L), removeRepetidos(L, Lista), length(Lista, N), N == 0).

% Pergunta 11
+jogo(IdJogo, Arbitro, Ajudas)::(findall(IdJogo, jogo(IdJogo, Arbitro, _), L), removeRepetidos(L, Lista), length(Lista, N), N =< 3).

% Pergunta 12
+jogo(IdJogo, Arbitro, Ajudas)::(findall(ID, jogo(ID, Arbitro, _), L), removeRepetidos(L, Lista), verificaJogos(Lista, IdJogo)).

verificaJogos(IdJogo, []).
verificaJogos(IdJogo, [H|T]) :- not(IdJogo =:= H + 1 ; IdJogo =:= H - 1), verificaJogos(IdJogo, T).

% Predicado de Evolução
evolucao(Termo) :- findall(Invariante, +Termo::Invariante, Lista), teste(Lista), insercao(Termo).
insercao(Termo) :- assert(Termo).

teste([]).
teste([R|RL]) :- R, teste(RL).

% Auxiliares
removeRepetidos([], L, Res, Res).
removeRepetidos([H|T], L, Aux, Res) :- not(member(H, L)), removeRepetidos(T, L, [H|Aux], Res).
removeRepetidos([H|T], L, Aux, Res) :- member(H, L), removeRepetidos(T, L, Aux, Res).
