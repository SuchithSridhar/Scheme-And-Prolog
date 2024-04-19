fib(0, 0).
fib(1, 1).
fib(N, Value) :-
    N >= 0,
    N1 is N - 1, fib(N1, Fib1),
    N2 is N -2, fib(N2, Fib2),
    Value is Fib1 + Fib2.
