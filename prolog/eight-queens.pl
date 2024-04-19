% sq(row, col)

% n_queens(N, Queens)
% should succeed if list of Queens is a solution 

% is_safe(Queen, OtherQueens).
% should succeed if Queen can be placed 
% without any other queen threating it.

is_safe(sq(_, _), []).
is_safe(sq(R1, C1), [sq(R2, C2)| T]) :-
    R1 =\= R2, C1 =\= C2,
    R1 - C1 =\= R2 - C2,
    R1 + C1 =\= R2 + C2,
    is_safe(sq(R1, C1), T). 


% partial_n_queen(N, Queens).
% Succeeds if the set of queens are safe on an NxN chessboard.

partial_n_queen(_, []).
partial_n_queen(N, [sq(Row, Col)|T]) :-
    length([sq(Row, Col)|T], Row),
    partial_n_queen(N, T),
    between(1, N, Col),
    is_safe(sq(Row, Col), T).


n_queens(N, Queens) :-
    length(Queens, N),
    partial_n_queen(N, Queens).
    

?- is_safe(sq(1, 1), []).
?- is_safe(sq(1, 1), [sq(2, 3)]).
?- not(is_safe(sq(1, 1), [sq(2, 2)])).
?- not(is_safe(sq(1, 1), [sq(1, 2)])).
?- not(is_safe(sq(1, 1), [sq(2, 1)])).
?- not(is_safe(sq(3, 1), [sq(1, 3)])).

?- partial_n_queen(4, []).
?- partial_n_queen(4, [sq(1, 1)]).
?- not(partial_n_queen(4, [sq(1, 5)])).
?- not(partial_n_queen(4, [sq(5, 1)])).
?- not(partial_n_queen(4, [sq(2, 1), sq(1, 2)])).
?- not(partial_n_queen(4, [sq(3, 3), sq(2, 1), sq(1, 2)])).
?- partial_n_queen(4, [sq(4, 2), sq(3, 4), sq(2, 1), sq(1, 3)]).

?- n_queens(4, [sq(4, 2), sq(3, 4), sq(2, 1), sq(1, 3)]).


