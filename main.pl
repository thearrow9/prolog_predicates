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

%generator subset_/2

subset_([], []).
subset_([Head | Tail], [Head | Result]) :- subset_(Tail, Result).
subset_([_ | Tail], Result) :- subset_(Tail, Result).

%predicate unique_list/2

u_iter([], R, R).
u_iter([Head | Tail], List, X) :- leave_one(List, Head, Result), u_iter(Tail, Result, X).

leave_one([], R, [R]) :- !.
leave_one([Head | Tail], Head, Result) :- leave_one(Tail, Head, Result).
leave_one([Head | Tail], Element, [Head | Result]) :- leave_one(Tail, Element, Result).

unique_list(List, X) :- u_iter(List, List, X).



%tests
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

%subset_
test(subset_, fail) :- subset_([1, 2, 3, 4], [1, 5]).
test(subset_, nondet) :- subset_([1, 2, 3, 4], []).
test(subset_, nondet) :- subset_([1, 2, 3, 4], [1, 2]).

%leave_one
test(leave_one, nondet) :- leave_one([5, 3, 2, 1, 5], 5, [3, 2, 1, 5]).


:- end_tests(testing).

?- run_tests.
