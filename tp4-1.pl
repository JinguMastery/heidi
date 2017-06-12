% implémentation de la partie "Syntaxe abstraite" et "Sémantique"

% définition des ordres de Heidi
order(deponer).
order(dretg).
order(sanester).
order(davent).
order(davos).
order(plaun).
order(returnar).
order(safermar).

% définition des coups de sifflets pour Tita
whistle(court).
whistle(whee).
whistle(wheet).
whistle(wheeo).
whistle(who).
whistle(hee).
whistle(long).

% définition de la pause entre les coups de sifflets
pause(pause).

% définition des traductions des ordres de Heidi en coups de sifflet
translation(deponer, [court, court]).
translation(dretg, [whee, who]).
translation(sanester, [wheet, wheeo]).
translation(davent, [wheet, wheeo, wheet, wheet]).
translation(davos, [who, hee, who]).
translation(plaun, [hee, hee, hee, hee]).
translation(returnar, [whee, whee, wheet]).
translation(safermar, [long]).

% sémantique des séquences de coups de sifflet ainsi que des séances de travail basées sur celles-ci
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

workSequence(X) :-
    X = [WhistleH|WhistleT],
    sequenceTita(WhistleH),
    WhistleT = [Y|T],
    pause(Y),
    workSequence(T).

% sémantique de traduction des ordres de Heidi en ordres pour Tita
heidiToTita(Order, Whistle) :-
    translation(Order, Whistle).

heidiToTita(Order, Whistle) :-
    Order = [X],
    translation(X, Whistle).

heidiToTita(Order, Whistle) :-
    Order = [OrderH|OrderT],
    Whistle = [WhistleH|WhistleT],
    translation(OrderH, WhistleH),
    WhistleT = [X|Y],
    pause(X),
    heidiToTita(OrderT, Y).

% sémantique de traduction des ordres compris par Tita en ordres pour Heidi (une simple règle)
titaToHeidi(Whistle, Order) :-
    heidiToTita(Order, Whistle).

% exemples de tests
?- workSequence([whee, wheet, wheeo, pause, long, court]). 
?- workSequence([who, wheeo, court, pause, hee, wheet, long, whee]).
?- heidiToTita([davos, sanester], [wheet, wheeo, wheet, pause, wheet, wheeo]).
?- heidiToTita([plaun, returnar, dretg], [wheet, wheeo, wheeo, pause, wheeo, wheet, pause, hee, wheet]).
?- titaToHeidi([wheeo, hee, wheet, pause, wheeo, wheeo], [deponer, safermar]).
?- titaToHeidi([wheet, hee, wheet, pause, wheet, wheeo, wheeo, pause, hee, wheet], [davent, plaun, dretg]).