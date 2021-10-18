filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).

pai(paulo,filipe).
pai(paulo,maria).

pai(P,F):-filho(F,P).

avo(antonio,nadia).

avo(A,N):-filho(X,A),filho(N,X).

neto(nuno,ana).

neto(N,A):-avo(A,N).

masc(joao).
masc(jose).

fem(maria).
fem(joana).

descendente(X,Y):-filho(X,Y).
descendente(X,Y):-filho(X,A),descendente(A,Y).

grauDesc(X,Y,1):-filho(X,Y).
grauDesc(X,Y,N):-filho(X,Z),grauDesc(Z,Y,G),N is G+1.

avoGrau(A,N):-grauDesc(N,A,2).

bisavo(X,Y):-grauDesc(X,Y,3).

trisavo(X,Y):-grauDesc(X,Y,4).