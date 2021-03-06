%73_C
%Write a PROLOG program that generates the list of all subsets with values between the [a, b]
%interval such that the sum of elements from each subset is an odd value. Write the mathematical
%models and flow models for the predicates used. For example, for a=2 and b=4 ⇒
%[[2,3],[3,4],[2,3,4]] (not necessarily in this order).

candidate(_,B,B).
candidate(A,B,E):-
	B>A,
	NewB is B-1,
	candidate(A,NewB,E).

subset(_,_,S,Col,Col):-
	S mod 2 =:= 1.
subset(A,B,S,[H|Col],RL):-
	candidate(A,B,E),
	E<H,
	NewS is S+E,
	subset(A,B,NewS,[E,H|Col],RL).

sol(A,B,RL):-
	candidate(A,B,E),
	subset(A,B,E,[E],RL).

allsol(A,B,RL):-
	findall(RPart,sol(A,B,RPart),RL).

%k partitions

partition([],[],[]).
partition([H|T],[H|P1],P2):-
	partition(T,P1,P2).
partition([H|T],P1,[H|P2]):-
	partition(T,P1,P2).

%kpartitions(l1l2...ln)={[],n=0
%			(l1Up1)Ukpartitions(p2),where [p1,p2]=partition(l2...ln)}

kpartitions([],[]).
kpartitions([H|T],[[H|P1]|R]):-
	partition(T,P1,P2),
	kpartitions(P2,R).

checkNrElem([],0).
checkNrElem([_|T],K):-
	NewK is K-1,
	checkNrElem(T,NewK).

sol1(L,K,RL):-
	kpartitions(L,RL),
	checkNrElem(RL,K).


allsol1(L,K,RL):-
	findall(RPart,sol1(L,K,RPart),RL).
