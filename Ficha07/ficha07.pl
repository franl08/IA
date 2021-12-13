% Problema de Pesquisa Informada e de Estado Único
% Estado Inicial - Qualquer Nodo
% Estado Objetivo - Nodo Lisboa
% Pré-Condições - Existe Caminho do estado inicial ao estado objetivo
% Custo da Solução - (Soma dos Custos de Tempo, Soma dos Custos de Distância)

% Arestas: (nodoInicial, nodoFinal, tuplo(custoDistância, custoTempo))
aresta(alandroal, redondo, tuplo(25, 10)).
aresta(redondo, monsaraz, tuplo(30, 20)).
aresta(monsaraz, barreiro, tuplo(120, 60)).
aresta(barreiro, palmela, tuplo(25, 20)).
aresta(barreira, baixa_da_banheira, tuplo(5, 5)).
aresta(baixa_da_banheira, moita, tuplo(7, 6)).
aresta(moita, alcochete, tuplo(20, 20)).
aresta(alcochete, lisboa, tuplo(20, 15)).
aresta(alandroal, elvas, tuplo(40, 25)).
aresta(elvas, arrailos, tuplo(50, 30)).
aresta(arrailos, alcacer, tuplo(90, 60)).
aresta(alcacer, palmela, tuplo(30, 30)).
aresta(palmela, almada, tuplo(25, 20)).
aresta(almada, lisboa, tuplo(15, 20)).
aresta(elvas, borba, tuplo(15, 10)).
aresta(borba, estremoz, tuplo(15, 10)).
aresta(estremoz, evora, tuplo(40, 25)).
aresta(evora, montemor, tuplo(20, 15)).
aresta(montemor, vendas_novas, tuplo(15, 10)).
aresta(vendas_novas, lisboa, tuplo(50, 30)).

% Nodos: (nodo, custoEstimDist, custoEstimTempo)
nodo(alandroal, 180, 90).
nodo(redondo, 170, 80).
nodo(monsaraz, 120, 70).
nodo(barreiro, 30, 20).
nodo(baixa_da_banheira, 33, 25).
nodo(moita, 35, 20).
nodo(alcochete, 26, 15).
nodo(almada, 25, 20).
nodo(palmela, 40, 25).
nodo(alcacer, 65, 45).
nodo(arrailos, 190, 80).
nodo(elvas, 270, 150).
nodo(borba, 250, 90).
nodo(estremoz, 145, 85).
nodo(evora, 95, 68).
nodo(montemor, 70, 40).
nodo(vendas_novas, 45, 30).

% Verifica se dois nodos são adjacentes, devolvendo o tuplo associado a ambas, por unificação
adjacente(A, B, Tuplo) :- aresta(A, B, Tuplo).
adjacente(B, A, Tuplo) :- aresta(B, A, Tuplo).

% Devolve o custo da distância associado a uma aresta
getDistancia(tuplo(Dist, Tempo), Dist).
custoDistancia(A, B, Dist) :- adjacente(A, B, Tuplo), getDistancia(Tuplo, Dist).

% Devolve o custo do tempo associado a uma aresta
getTempo(tuplo(Dist, Tempo), Tempo).
custoTempo(A, B, Tempo) :- adjacente(A, B, Tuplo), getTempo(Tuplo, Tempo).

% Devolve a lista dos nodos adjacentes
listaDeAdjacentes(Nodo, ListaAdj) :- findall(N, adjacente(Nodo, N, _), ListaAdj).

% Devolve a soma do custo das arestas (Tempo + Distância)
somaCustos(A, Total) :- nodo(A, Distância, Tempo), Total is Distância + Tempo.

% Devolve o nodo com menor custo
menorCusto([H|Cauda], Nodo) :- somaCustos(H, Acum), menorCustoAux(Cauda, H, Acum, Nodo).

menorCustoAux([], Nodo, Acum, Nodo).
menorCustoAux([H|Cauda], Menor, Acum, Nodo) :- somaCustos(H, Valor), Valor < Acum, menorCustoAux(Cauda, H, Valor, Nodo).
menorCustoAux([H|Cauda], Menor, Acum, Nodo) :- somaCustos(H, Valor), Valor >= Acum, menorCustoAux(Cauda, Menor, Acum, Nodo).

% Remove elementos repetidos de uma lista
removeRepetidos([], L, Resultado, Resultado).
removeRepetidos([H|T], L, Aux, Resultado) :- not(member(H, L)), removeRepetidos(T, L, [H|Aux], Resultado).
removeRepetidos([H|T], L, Aux, Resultado) :- member(H, L), removeRepetidos(T, L, Aux, Resultado).

% Greedy Search (Pesquisa Gulosa)
greedySearch(Inicial, Caminho, CustoDist, CustoTemp) :- greedySearchAux(Inicial, [], 0, 0, Caminho, CustoDist, CustoTemp).

greedySearchAux(lisboa, Visitados, CustoDist, CustoTemp, Caminho, CustoDist, CustoTemp) :- reverse([lisboa|Visitados], Caminho).
greedySearchAux(Inicial, Visitados, Dist, Temp, Caminho, CustoDist, CustoTemp) :- listaDeAdjacentes(Inicial, Lista), 
                                                                                  removeRepetidos(Lista, Visitados, [], Final),
                                                                                  menorCusto(Final, ProxNodo),
                                                                                  custoTempo(Inicial, ProxNodo, T),
                                                                                  custoDistancia(Inicial, ProxNodo, D),
                                                                                  TempN is CustoTemp + T,
                                                                                  DistN is CustoDist + D,
                                                                                  greedySearchAux(ProxNodo, [Inicial|Visitados], DistN, TempN, Caminho, CustoDist, CustoTemp),
                                                                                  !.
