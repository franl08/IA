:- style_check(-singleton).
:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.

voa(X) :- ave(X), not(excecao(voa(X))).
voa(X) :- excecao(-voa(X)).

-voa(X) :- mamifero(X), not(excecao(-voa(X))).

-voa(tweety).

ave(pitigui).

ave(X) :- canario(X).

ave(X) :- periquito(X).

periquito(faísca).

canario(piupiu).

mamifero(silvestre).

mamifero(X) :- cao(X).

mamifero(X) :- gato(X).

gato(bichano).

cao(boby).

ave(X) :- avestruz(X).

ave(X) :- pinguim(X).

avestruz(trux).
excecao(voa(X)) :- avestruz(X).

pinguim(pingú).

mamifero(X) :- morcego(X).
morcego(batman).
excecao(-voa(X)) :- morcego(X).

si(Questao, verdadeiro) :- Questao.
si(Questao, false) :- -Questao.
si(Questao, desconhecido) :- nao(Questao), nao(-Questao).

nao(Questao) :- Questao, !, fail.
nao(Questao).