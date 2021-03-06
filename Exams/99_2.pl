%99_B
%Given a list composed of integer numbers and sublists of integer numbers, write a SWI-Prolog
%program that verifies if all the elements of the list (including those in sublists) form a symmetrical
%sequence. For example, for the list [1, 5, [2,4], 7, 11, 25, [11, 7, 4], 2, 5, 1] the result will be true.

appendL([],B,B):-!.
appendL([HA|A],B,[HA|RL]):-
	appendL(A,B,RL).

%linearize list
%linearize2 is better btw
linearize([],[]):-!.
linearize([H|T],RL):-
	!,
	linearize(H,F1),
	linearize(T,F2),
	appendL(F1,F2,RL).
linearize(L,[L]).

%better version
linearize2([],[]):-!.
linearize2([H|T],RL):-
	is_list(H),!,
	linearize2(H,F1),
	linearize2(T,F2),
	appendL(F1,F2,RL).
linearize2([H|T],[H|RL]):-
	linearize2(T,RL).

reverseL([],R,R).
reverseL([H|T],R,RL):-
	reverseL(T,[H|R],RL).

checkEqLists([],[]).
checkEqLists([HA|A],[HB|B]):-
	HA =:= HB,!,
	checkEqLists(A,B).

sol(L):-
	linearize2(L,L1),
	reverseL(L1,[],L2),
	checkEqLists(L1,L2).