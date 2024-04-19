% Knights Tour
% CSCI-3137: Assignment 9
% Author: Suchith Sridhar Khajjayam
% Date: 29 Mar 2024


% This sets the board size for the tour
board_size(rows(3), columns(4)).

% Checks to see if this is valid square on the board
sq(R, C) :- 
    board_size(rows(Rows), columns(Cols)),
    RBound is Rows - 1, CBound is Cols - 1,
    between(0, RBound, R), between(0, CBound, C).

% Contains all the directions that the knight can move in
knight_offsets([(1, 2), (2, 1), (-1, 2), (-2, 1), (1, -2), (2, -1), (-1, -2), (-2, -1)]).

% True if knight_move(A, B) is a valid move for a 
% knight starting from A going to B.
knight_move(sq(A, B), sq(C, D)) :-
    sq(A, B), sq(C, D),
    knight_offsets(Offsets),
    member((RowOffset, ColOffset), Offsets),
    plus(A, RowOffset, C),
    plus(B, ColOffset, D).

% helper predicate to recursively build the tour.
knights_tour_partial([], _).

knights_tour_partial([X], Visited) :-
    X = sq(_, _),
    not(member(X, Visited)).

knights_tour_partial(Partial, Visited) :-
    Partial = [First | Tail],
    Tail = [Second | _],
    knight_move(First, Second),
    not(member(First, Visited)),
    knights_tour_partial(Tail, [First | Visited]).

% True if Tour is a valid list tour for a knight on the board specified above.
knights_tour(Tour) :-
    board_size(rows(Rows), columns(Cols)),
    Length is Rows * Cols,
    length(Tour, Length),
    knights_tour_partial(Tour, []).

% Valid tour used for testing purposes
valid_tour_one([sq(0, 0), sq(1, 2), sq(2, 0), sq(0, 1), sq(1, 3), sq(2, 1), 
    sq(0, 2), sq(1, 0), sq(2, 2), sq(0, 3), sq(1, 1), sq(2, 3)]).

% Valid tour used for testing purposes
valid_tour_two([sq(0,0), sq(1,2), sq(2,0), sq(0,1), sq(1,3), sq(2,1), sq(0,2),
    sq(1,0), sq(2,2), sq(0,3), sq(1,1), sq(2,3)]).

?- knight_move(sq(0, 0), sq(1, 2)).
?- knight_move(sq(0, 0), sq(2, 1)).
?- not(knight_move(sq(-1, -1), sq(0, 1))).
?- knight_move(sq(1, 2), sq(0, 0)).
?- knight_move(sq(2, 1), sq(0, 0)).
?- knight_move(sq(2, 1), sq(1, 3)).

?- valid_tour_one(Tour), knights_tour(Tour).
?- valid_tour_two(Tour), knights_tour(Tour).

% Answers to Written parts:
%
% 1. To query the solution to produce a valid tour, we can perform the query: 
%
% ?- knights_tour(Tour).
% This will produce all the valid tours for the set board size.
%
% 2. We can query for a tour starting from a particular square by:
%
% ?- knights_tour([sq(2, 3) | Tail]).
% Where sq(2, 3) specifies the starting square. Tour will be all the valid tails
% for the tour that starts with the specified square.
%
% 3. We can find a valid tour and then check to see if it is one move away from
% the start of the tour. We can do this in the following way:
%
% ?- knights_tour(Tour), append([First | _], [Last], Tour), knight_move(Last, First).
%
% In the above process, we first find a tour, then extract the first and last
% elements and check if a knight can move from the last square to the first
% square.
% Turns out for a board size of 3 x 4, there is no valid tour where this is
% possible.
