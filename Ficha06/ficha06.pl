% Problema de Pesquisa Informada e de Estado Único
% Estado Inicial - Qualquer Nodo
% Estado Objetivo - Nodo t
% Pré-Condições - Existe um caminho do estado inicial até ao estado objetivo
% Custo da Solução - Soma do peso das arestas percorridas

% Definição das arestas do grafo: (nodo inicial, nodo final, peso)
aresta(s, e, 7).
aresta(e, f, 4).
aresta(f, g, 2).
aresta(g, t, 2).
aresta(d, t, 3).
aresta(c, d, 3).
aresta(b, c, 2).
aresta(a, b, 2).
aresta(s, a, 2).

% Definição dos nodos: (nodo, estimativa do Custo)
nodo(s, 10).
nodo(e, 7).
nodo(f, 4).
nodo(g, 2).
nodo(d, 3).
nodo(c, 4).
nodo(b, 4).
nodo(a, 5).

% Nodo é adjacente a determinado nodo?
adjacente(X, Y, C) :- aresta(X, Y, C).
adjacente(X, Y, C) :- aresta(Y, X, C).

% DFS com Custo
depthFirstCost(Inicio, Caminho, Custo) :- depthFirstCostAux(Inicio, [], 0, Caminho, Custo).

depthFirstCostAux(t, Visitados, Custo, Caminho, Custo) :- reverse([t|Visitados], Caminho).
depthFirstCostAux(Nodo, Visitados, Custo, Caminho, Total) :- adjacente(Nodo, X, Valor),
                                                            not(member(X, Visitados)),
                                                            CustoNovo is Custo + Valor,
                                                            depthFirstCostAux(X, [Nodo|Visitados], CustoNovo, Caminho, Total).

% Greedy Search (Pesquisa Gulosa)

% Obtém os adjacentes a um determinado nodo
listaDeAdjacentes(X, Lista) :- findall(Y, adjacente(X, Y, _), Lista).

% Retorna o nodo com menor custo aproximado ao destino
menorCustoGreedy([H|ListaAdj], X) :- nodo(H, CustoAprox), menorCustoAux(ListaAdj, CustoAprox, H, X).

menorCustoAux([], CustoAprox, X, X).
menorCustoAux([H|T], CustoAprox, NodoMaisPerto, X) :- nodo(H, Y), Y >= CustoAprox, menorCustoAux(T, CustoAprox, NodoMaisPerto, X).
menorCustoAux([H|T], CustoAprox, NodoMaisPerto, X) :- nodo(H, Y), Y < CustoAprox, menorCustoAux(T, Y, H, X).

% Algoritmo Greedy Search:
greedySearch(Inicio, Caminho, Custo) :- greedySearchAux(Inicio, [], 0, Caminho, Custo).

greedySearchAux(t, Visitados, Custo, Caminho, Custo) :- reverse([t|Visitados], Caminho).
greedySearchAux(Nodo, Visitados, Custo, Caminho, Total) :- listaDeAdjacentes(Nodo, ListaAdj),
                                                           menorCustoGreedy(ListaAdj, ProxNodo),
                                                           not(member(ProxNodo, Visitados)),
                                                           adjacente(Nodo, ProxNodo, Valor),
                                                           NovoCusto is Custo + Valor,
                                                           greedySearchAux(ProxNodo, [Nodo|Visitados], NovoCusto, Caminho, Total).