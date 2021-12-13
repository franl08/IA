:- op(900, xfy, '::').
:- dynamic servico/2.
:- dynamic ato/4.

% Aplicação do PMF
-servico(Servico, Nome) :- nao(servico(Servico, Nome)),
                           nao(excecao(servico(Servico, Nome))).

-ato(Ato, Prestador, Utente, Dia) :- nao(ato(Ato, Prestador, Utente, Dia)),
                                     nao(excecao(ato(Ato, Prestador, Utente, Dia))).

% Linha 1
servico(ortopedia, amelia).
ato(penso, ana, joana, sabado).

% Linha 2
servico(obstetricia, ana).
ato(gesso, amelia, jose, domingo).

% Linha 3
servico(obstetricia, maria).
ato('#017', mariana, joaquina, domingo).
excecao(ato(Ato, Prestador, Utente, Data)) :- ato('#017', Prestador, Utente, Data).

% Linha 4
servico(obstetricia, mariana).
ato(domicilio, maria, '#121', '#251').
excecao(ato(Ato, Prestador, Utente, Data)) :- ato(Ato, Prestador, '#121', '#251').

% Linha 5
servico(geriatria, sofia).
ato(domicilio, susana, joao, segunda).
ato(domicilio, susana, jose, segunda).

% Linha 6
servico(geriatria, susana).
ato(sutura, '#313', josue, segunda).
excecao(ato(Ato, Prestador, Utente, Data)) :- ato(Ato, '#313', Utente, Data).

% Linha 7
servico('#007', teodora).
excecao(servico(Servico, Nome)) :- servico('#007', Nome).
ato(sutura, maria, josefa, terca).
ato(sutura, maria, josefa, sexta).
ato(sutura, mariana, josefa, terca).
ato(sutura, mariana, josefa, sexta).

% Linha 8
servico('@NP9', zulmira).
excecao(servico(Servico, Nome)) :- servico('@NP9', Nome).
nulo('@NP9').
+servico(Servico, Nome)::findall(S,(servico(S, N), not(nulo(S)), L), length(L, N), N == 0).
excecao(ato(penso, ana, jacinta, Data)) :- member(Data, [segunda, terca, quarta, quinta, sexta, sabado, domingo]).

% Assumindo que existe o predicado isFeriado(X) que devolve True em caso de ser Feriado
feriado(X) :- isFeriado(X).

+ato(Ato, Prestador, Utente, Data)::(not(feriado(Data))).

-servico(S, Prestador)::(findall(Ato, ato(_, Prestador, _, _), Lista), length(Lista, N), N == 0).

evolucao(Termo) :-
    findall(Invariante, +Termo::Invariante, Lista),
    insercao(Termo),
    teste(Lista).

insercao(Termo) :- assert(Termo).
teste([]).
teste([R|RT]) :- R, teste(RT).

involucao(Termo):-
    findall(Invariante, -Termo::Invariante, Lista),
    remocao(Termo),
    teste(Lista).

remocao(Termo) :- retract(Termo).

% Predicado demo
demo(Questao, verdadeiro) :- Questao.
demo(Questao, falso) :- -Questao.
demo(Questao, desconhecido) :- nao(Questao), nao(-Questao).

% Predicado nao
nao(Questao) :- Questao, !, fail.
nao(Questao).