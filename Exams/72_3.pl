%Write a PROLOG program that determines from a list made of integer numbers, the list of
%subsets with at least 2 elements, composed of numbers in strictly increasing order. Write the
%mathematical models and flow models for the predicates used. For example for the list [1, 8, 6, 4] ⇒
%[[1,8],[1,6],[1,4],[6,8],[4,8],[4,6],[1,4,6],[1,4,8],[1,6,8],[4,6,8],[1,4,6,8]] (not necessarily
%in this order).

candidate([H|T],H,T).
candidate([H|T],E,[H|RL]):-
	candidate(T,E,RL).

solution(_,K,Col,Col):-
	K >= 2.
solution(L,K,[H|Col],RL):-
	candidate(L,E,List),
	E<H,
	K1 is K + 1,
	solution(List,K1,[E,H|Col],RL).

solWrap(L,RL):-
	candidate(L,E,List),
	solution(List,1,[E],RL).

allsol(L,RL):-
	findall(RPart,solWrap(L,RPart),RL).
