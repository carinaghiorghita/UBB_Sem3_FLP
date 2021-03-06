%106_C
%Write a PROLOG program that generates the list of all subsets of sum S given, using the
%elements of a list, such that the number of even elements from each subset is even. Write the
%mathematical models and flow models for the predicates used. For example for the list
%[1, 2, 3, 4, 5, 6, 10] and S=10 ⇒ [[1,2,3,4], [4,6]].

%checkCond(l1l2...ln,S,S1,K)={true,n=0,S=S1,K%2==0
%				false,n=0 and S!=S1 or K%2==1
%				checkCond(l2...ln,S+l1,S1,K+1),l1%2==0
%				checkCond(l2...ln,S+l1,S1,K),oth}

checkCond([],K):-
	K mod 2 =:= 0,!.
checkCond([H|T],K):-
	H mod 2 =:= 0,!,
	NewK is K+1,
	checkCond(T,NewK).
checkCond([_|T],K):-
	checkCond(T,K).

candidate([H|T],H,T).
candidate([H|T],E,[H|RL]):-
	candidate(T,E,RL).

subset(_,S,S1,Col,Col):-
	S =:= S1,
	checkCond(Col,0).
subset(L,S,S1,[H|Col],RL):-
	candidate(L,E,List),
	E<H,
	NewS is S+E,
	subset(List,NewS,S1,[E,H|Col],RL).

solWrap(L,S,RL):-
	candidate(L,E,List),
	subset(List,E,S,[E],RL).

allsol(L,S,RL):-
	findall(RPart,solWrap(L,S,RPart),RL).

%arithmetic progression
% we'll get the diff between the first two elems before calling this
% function
checkArithmProgr([H1,H2],D):-
	D =:= H2-H1,!.
checkArithmProgr([H1,H2|T],D):-
	H2-H1 =:= D,
	checkArithmProgr([H2|T],D).
	
