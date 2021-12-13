filho(joao, jose).
filho(jose, manuel).
filho(carlos, jose).
:-discontiguous filho/2.

pai(paulo, filipe).
pai(paulo, maria).
:-discontiguous pai/2.


avo(antonio, nadia).
:-discontiguous avo/2.


neto(nuno, ana).
:-discontiguous neto/2.


masculino(joao).
masculino(jose).

feminino(maria).
feminino(joana).

pai(X, Y) :- filho(Y, X).

avo(A, N) :- filho(N, X) , pai(A, X).
avo(A, N) :- descendente(N, A, 2).

bisavo(B, N) :- descendente(N, B, 3).

trisavo(T, N) :- descendente(N, T, 3).

neto(N, A) :- avo(A, N).

descendente(X, Y) :- filho(X, Y).
descendente(X, Y) :- filho(X, A) , descendente(A, Y).

descendente(X, Y, 1) :- filho(X, Y).
descendente(X, Y, R) :- filho(X, A) , descendente(A, Y, N), R is N + 1.

