abs(X, AbsX) :-
    X > 0,
    AbsX is X.

abs(X, AbsX) :-
    0 >= X,
    AbsX is -X.
