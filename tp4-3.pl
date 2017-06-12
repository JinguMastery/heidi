% impl�mentation de la partie "Acc�l�ration"

% d�finition des ordres de Heidi
order(deponer).
order(dretg).
order(sanester).
order(davent).
order(davos).
order(plaun).
order(returnar).
order(safermar).

% d�finition des coups de sifflets pour Tita
whistle(court).
whistle(whee).
whistle(wheet).
whistle(wheeo).
whistle(who).
whistle(hee).
whistle(long).

% d�finition des traductions des ordres de Heidi en coups de sifflet
translation(deponer, [wheeo, hee, wheet]).
translation(dretg, [hee, wheet]).
translation(sanester, [wheet, wheeo]).
translation(davent, [wheet, hee, wheet]).
translation(davos, [wheet, wheeo, wheet]).
translation(plaun, [wheet, wheeo, wheeo]).
translation(returnar, [wheeo, wheet]).
translation(safermar, [wheeo, wheeo]).

% d�finition des suites d'ordres donn�s par Heidi
orderHeidi(X) :-
    order(X).

orderHeidi([H|T]) :-
    order(H),
    T = [].

orderHeidi([H|T]) :-
    order(H),
    orderHeidi(T).

% s�mantique des s�quences de coups de sifflet ainsi que des s�ances de travail bas�es sur celles-ci
sequenceTita(X) :-
    whistle(X).

sequenceTita([H|T]) :-
    whistle(H),
    T = [].

sequenceTita([H|T]) :-
    whistle(H),
	sequenceTita(T).

workSequence(X) :-
    sequenceTita(X).

workSequence([H|T]) :-
    sequenceTita(H),
    workSequence(T).

% s�mantique de traduction des ordres de Heidi en ordres pour Tita
heidiToTita(Order, Whistle) :-
    translation(Order, Whistle).

heidiToTita(Order, Whistle) :-
    Order = [X],
    translation(X, Whistle).

heidiToTita(Order, Whistle) :-
    Order = [OrderH|OrderT],
    Whistle = [WhistleH|WhistleT],
    translation(OrderH, WhistleH),
    heidiToTita(OrderT, WhistleT).

% s�mantique de traduction des ordres compris par Tita en ordres pour Heidi (une simple r�gle)
titaToHeidi(Whistle, Order) :-
    heidiToTita(Order, Whistle).

% on v�rifie que les ordres donn�es par Heidi sont bien ex�cut�s par Tita
verify(X) :- 
    orderHeidi(X), 
    heidiToTita(X, Y),
    titaToHeidi(Y, Z),
    !,
    X = Z.

% exemples de tests
?- orderHeidi([deponer, plaun]).
?- workSequence([whee, wheet, wheeo, long, court]). 
?- workSequence([who, wheeo, court, hee, wheet, long, whee]).
?- heidiToTita([davos, sanester], [wheet, wheeo, wheet, wheet, wheeo]).
?- heidiToTita([plaun, returnar, dretg], [wheet, wheeo, wheeo, wheeo, wheet, hee, wheet]).
?- titaToHeidi([wheeo, hee, wheet, wheeo, wheeo], [deponer, safermar]).
?- titaToHeidi([wheet, hee, wheet, wheet, wheeo, wheeo, hee, wheet], [davent, plaun, dretg]).
?- verify([plaun, safermar, davos, davent, sanester]).
?- verify([plaun, dretg, plaun, deponer, safermar]).