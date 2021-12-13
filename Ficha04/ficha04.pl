g(grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
    [aresta(madrid, cordoba, a4, 400),
     aresta(braga, guimaraes, a11, 25),
     aresta(braga, vilareal, a11, 107),
     aresta(guimaraes, viseu, a24, 174),
     aresta(vilareal, lamego, a24, 37),
     aresta(viseu, lamego, a24, 61),
     aresta(viseu, coimbra, a25, 119),
     aresta(viseu, guarda, a25, 75)]
    )).

adjacente(X, Y, E, K, grafo(_,Es)) :- member(aresta(X, Y, E, K), Es).
adjacente(X, Y, E, K, grafo(_,Es)) :- member(aresta(Y, X, E, K), Es).

caminho(G, A, B, P) :- caminho1(G, A, [B], P).

caminho1(_, A, [A|P1], [A|P1]).
caminho1(G, A, [Y|P1], P) :- adjacente(X, Y, _, _, G), not(member(X, [Y|P1])), caminho1(G, A, [X, Y | P1], P).

ciclo(G, A, P) :- adjacente(B, A, _, _, G), caminho(G, A, B, P1), length(P1, L) > 2, append(P1, [A], P).

caminhoK(G, A, B, P, Km, Es) :- caminhoAux(G, A, [B], 0, [], (P, Km, Es)).

caminhoAux(_, A, [A|P1], Km, Es, ([A|P1], Km, Es)).
caminhoAux(G, A, [Y|P1], Km, Es, (P, Km1, Es1)) :- adjacente(X, Y, Estrada, Dist, G), not(member(X, [Y|P1])), Km2 is Km + Dist, caminhoAux(G, A, [X, Y | P1], Km2, [Estrada|Est], (P, Km1, Es1)).

cicloK(G, A, Km, Es) :- adjacente(B, A, Es1, Km1, G), caminhoK(G, A, B, P, Dist, Est), length(P1, L) > 2, append(P1, [A], P), Km is Km1 + Dist.