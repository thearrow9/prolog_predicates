%rewriting append/3

append_([], Rest, Rest).
append_([Head | Tail], New, [Head | Result]) :- append_(Tail, New, Result).

%rewriting permutation/2

permut(List, X) :- permut_(List, [], X).

permut_([], Collected, Collected).
permut_(List, Result, X) :- gen_member(List, Member), remove_member(List, Member, Newlist), append_(Result, [Member], Newresult), permut_(Newlist, Newresult, X).

gen_member([X | _], X).
gen_member([_ | Tail], X) :- gen_member(Tail, X).

remove_member([Head | Tail], Head, Tail).
remove_member([Head | Tail], X, [Head | Result]) :- remove_member(Tail, X, Result).

:- begin_tests(testing).

%append_ []
test(append_, nondet) :- append_([a, b, c], [], [a, b, c]).

%append_ item
test(append_, fail) :- append_([a, b], c, [a, b, c]).
test(append_, nondet) :- append_([a, b], [c], [a, b, c]).

%append_ list
test(append_, nondet) :- append_([a, c], [a, b], [a, c, a, b]).

%remove_member
test(remove_member, nondet) :- remove_member([a], a, []).
test(remove_member, fail) :- remove_member([a], r, []).
test(remove_member, nondet) :- remove_member([1, 2, 3, 2, 3, 2], 2, [1, 3, 2, 3, 2]).

:- end_tests(testing).

?- run_tests.
