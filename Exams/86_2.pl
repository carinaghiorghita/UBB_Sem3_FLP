%86_B
%Given a numerical linear list, write a SWI-PROLOG program that applies a stable sorting on this list
%and sorts the elements in increasing order by the reminder of the division with 3. For example, for the
%list [10, 5, 6, 12, 7, 3, 20, 30] the result will be [6, 12, 3, 30, 10, 7, 5, 20]. (Obs: stable sort means
%that elements that are equal elements will remain in the same order as in the initial list, for example 6
%and 12).

getMod0([],[]).
getMod0([H|T],[H|RL]):-
	H mod 3 =:= 0,!,
	getMod0(T,RL).
getMod0([_|T],RL):-
	getMod0(T,RL).

getMod1([],[]).
getMod1([H|T],[H|RL]):-
	H mod 3 =:= 1,!,
	getMod1(T,RL).
getMod1([_|T],RL):-
	getMod1(T,RL).

getMod2([],[]).
getMod2([H|T],[H|RL]):-
	H mod 3 =:= 2,!,
	getMod2(T,RL).
getMod2([_|T],RL):-
	getMod2(T,RL).

addListToList1([],B,B).
addListToList1([HA|A],B,[HA|RL]):-
	addListToList1(A,B,RL).

sol2(L,R):-
	getMod0(L,L0),
	getMod1(L,L1),
	getMod2(L,L2),
	addListToList1(L1,L2,R1),
	addListToList1(L0,R1,R).
