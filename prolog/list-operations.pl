my_member(E, [E|_]).
my_member(E, [_|T]) :- my_member(E, T).

?- not(my_member(_, [])).
?- my_member(1, [1]).
?- my_member(1, [2, 1]).
?- not(my_member(3, [1,2,4])).

my_select(H, [H|T], T).
my_select(E, [H|T], [H|RT]) :- my_select(E, T, RT).

?- not(my_select(_, [], _)).
?- my_select(1, [1|T], T).
?- my_select(1, [0,1], [0]).
?- my_select(1, [1, 0], [0]).
?- my_select(5, [1, 0, 2, 3, 5, 7, 8], [1, 0, 2, 3, 7, 8]).

?- my_select(4, [1,4,3,4], [1, 3, 4]).
?- my_select(4, [1,4,3,4], [1, 4, 3]).

subset([], _).
subset([H1|T1], L2) :- member(H1, L2), subset(T1, L2).

set_equals([], []).
set_equals(L1, L2) :- subset(L1, L2), subset(L2, L1).

?- set_equals([], []).
?- set_equals([1], [1]).
?- not(set_equals([1], [1, 2])).
?- not(set_equals([1, 2], [1])).
?- set_equals([1, 2], [2, 1]).
?- set_equals([1, 2, 1], [1, 2]).


perm([], []).

perm([H1|T1], L2) :- 
    ground([H1|T1]),
    perm(T1, X),
    select(H1, L2, X).

perm(L2, [H1|T1]) :- 
    ground([H1|T1]),
    perm(T1, X),
    select(H1, L2, X).

?- perm([], []).
?- perm([1], [1]).
?- not(perm([1], [1, 2])).
?- not(perm([1, 2], [1])).
?- perm([1, 2], [2, 1]).
?- not(perm([1, 2, 1], [1, 2])).
