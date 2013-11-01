%testing append predicate

append_([], Rest, Rest).
append_([Head | Tail], New, [Head | Result]) :- append_(Tail, New, Result).


:- begin_tests(tester).

%append []
test(append_, nondet) :- append_([a, b, c], [], [a, b, c]).

%append item
test(append_, fail) :- append_([a, b], c, [a, b, c]).
test(append_, nondet) :- append_([a, b], [c], [a, b, c]).

%append list
test(append_, nondet) :- append_([a, c], [a, b], [a, c, a, b]).

:- end_tests(tester).

?- run_tests.
