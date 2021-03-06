%13.
%a. Given a linear numerical list write a predicate to remove all sequences of consecutive values.
%Eg.: remove([1, 2, 4, 6, 7, 8, 10], L) will produce L=[4, 10].
%b. For a heterogeneous list, formed from integer numbers and list of numbers; write a predicate to delete from
%every sublist all sequences of consecutive values.
%Eg.: [1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7] =>
%[1, [5], 9, [4, 7, 9], 11, [5, 8, 2], 7]

%13a

%removeCons(l1l2...ln)={l1...ln,n<=1
%			[],n=2 and l1=l2-1
%			removeCons(l3...ln),l1=l2-1 and l2!=l3-1
%			removeCons(l2...ln),l1=l2-1 and l2=l3-1
%			l1+removeCons(l2...ln),l1!=l2-1}

%removeCons(L-list, RL- res list)
%flow model (i,o) deterministic

removeCons([],[]):-!.
removeCons([H],[H]):-!.
removeCons([H1,H2],[]):-
	NewH is H1+1,
	NewH =:= H2,!.
removeCons([H1,H2,H3|T],RL):-
	NewH1 is H1+1,
	NewH1 =:= H2,
	NewH2 is H2+1,
	NewH2 =:= H3,
	removeCons([H2,H3|T],RL),!.
removeCons([H1,H2,H3|T],RL):-
	NewH1 is H1+1,
	NewH1 =:= H2,
	NewH2 is H2+1,
	NewH2 =\= H3,
	removeCons([H3|T],RL),!.
removeCons([H1,H2|T],[H1|RL]):-
	NewH is H1+1,
	NewH =\= H2,
	removeCons([H2|T],RL),!.


%13b

%removeFromSublist(l1l2...ln)={[],n=0
%				l1+removeFromSublist(l2...ln),l1 is number
%				removeCons(l1)+removeFromSublist(l2...ln),l1 is list}

%removeFromSublist(L-list, RL-res list)
%flow model (i,o)

removeFromSublist([],[]).
removeFromSublist([H|T],[HR|RL]):-
	is_list(H),!,
	removeCons(H,HR),
	removeFromSublist(T,RL).
removeFromSublist([H|T],[H|RL]):-
	removeFromSublist(T,RL).
