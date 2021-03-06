%3.
%a. Merge two sorted lists with removing the double values.
%b. For a heterogeneous list, formed from integer numbers and list of numbers, merge all sublists with removing
%the double values.
%[1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
%[1, 2, 3, 4, 6, 7, 9, 10, 11].

%3a

%mergeL(a1a2...an,b1b2...bm)={b,n=0
%				a,m=0
%				a1+mergeL(a2...an,b2...bm),a1=b1
%				a1+mergeL(a2...an,b1b2...bm),a1<b1
%				b1+mergeL(a1a2...an,b2...bm),b1<a1}

%mergeL(A-list,B-list,RL-resulting list)
%flow model (i,i,o) deterministic

mergeL([],B,B):-!.
mergeL(A,[],A):-!.
mergeL([HA|A],[HB|B],RL):-
	HA=:=HB,!,
	mergeL([HA|A],B,RL).
mergeL([HA|A],[HB|B],[HA|RL]):-
	HA<HB,!,
	mergeL(A,[HB|B],RL).
mergeL([HA|A],[HB|B],[HB|RL]):-
	mergeL([HA|A],B,RL).

%3b
%mergeSub(l1l2...ln)={[],n=0
%			mergeSub(l2...ln),l1 is number,
%			mergeL(l1,mergeSub(l2...ln)),l1 is list}

%mergeSub(L-list, RL-res list)
%flow model (i,o) determ

mergeSub([],[]).
mergeSub([H|T],RL):-
	is_list(H),!,
	mergeSub(T,HR),
	mergeL(H,HR,RL).
mergeSub([_|T],RL):-
	mergeSub(T,RL).
