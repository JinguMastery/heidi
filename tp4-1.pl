% impl�mentation de la partie "Syntaxe abstraite" et "S�mantique"

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

% d�finition de la pause entre les coups de sifflets
pause(pause).

% d�finition des traductions des ordres de Heidi en coups de sifflet
translation(deponer, [court, court]).
translation(dretg, [whee, who]).
translation(sanester, [wheet, wheeo]).
translation(davent, [wheet, wheeo, wheet, wheet]).
translation(davos, [who, hee, who]).
translation(plaun, [hee, hee, hee, hee]).
translation(returnar, [whee, whee, wheet]).
translation(safermar, [long]).

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

workSequence(X) :-
    X = [WhistleH|WhistleT],
    sequenceTita(WhistleH),
    WhistleT = [Y|T],
    pause(Y),
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
    WhistleT = [X|Y],
    pause(X),
    heidiToTita(OrderT, Y).

% s�mantique de traduction des ordres compris par Tita en ordres pour Heidi (une simple r�gle)
titaToHeidi(Whistle, Order) :-
    heidiToTita(Order, Whistle).

% exemples de tests
?- workSequence([whee, wheet, wheeo, pause, long, court]). 
?- workSequence([who, wheeo, court, pause, hee, wheet, long, whee]).
?- heidiToTita([davos, sanester], [wheet, wheeo, wheet, pause, wheet, wheeo]).
?- heidiToTita([plaun, returnar, dretg], [wheet, wheeo, wheeo, pause, wheeo, wheet, pause, hee, wheet]).
?- titaToHeidi([wheeo, hee, wheet, pause, wheeo, wheeo], [deponer, safermar]).
?- titaToHeidi([wheet, hee, wheet, pause, wheet, wheeo, wheeo, pause, hee, wheet], [davent, plaun, dretg]).