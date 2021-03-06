%Given a numeric linear list, write a SWI-PROLOG program that returns (as a list of pairs) all possible
%partitions of the initial list in two sublists, such that the average value of the elements from the first
%sublist is smaller or equal to the greatest common divisor of the elements from the second sublist. For
%example, for the list [8, 4, 6, 1], the result will be (not necessarily in this order): 
%[[[1, 4, 8], [6]], [[1, 6, 4], [8]], [[1, 6], [4, 8]], [[1], [6, 4, 8]]].

%average(l1l2...ln,S,k)={S/k,n=0
%			average(l2...ln,S+l1,k+1),otherwise}

average([],S,K,Res):-
	K =\= 0,
	Res is S / K,!.
average([H|T],S,K,Res):-
	NewS is S+H,
	NewK is K+1,
	average(T,NewS,NewK,Res).

averageWrapper(L,Res):-
	average(L,0,0,Res).

%gcdTwoNr(a,b)={a,b=0
%		gcdTwoNr(b,a%b),otherwise}

gcdTwoNr(A,0,A):-!.
gcdTwoNr(A,B,Res):-
	NewB is A mod B,
	gcdTwoNr(B,NewB,Res).

%gcdList(l1l2...ln)={l1,n=1
%			gcdTwoNr(l1,gcdList(l2...ln)),otherwise}

gcdList([H],H):-!.
gcdList([H|T],Res):-
	gcdList(T,ResP),
	gcdTwoNr(H,ResP,Res).

%checkCondTwoLists(a1a2...an,b1b2..bm)={true,averageWrapper(a)<=gcdList(b)
%					false,oth}

checkCondTwoLists(A,B):-
	averageWrapper(A,RA),
	gcdList(B,RB),
	RA<RB.

%partition(l1l2..ln,p1,p2)={p1=[],p2=[],if n=0
%			partition(l2...ln,l1Up1,p2)
%			partition(l2...ln,p1,l1Up2)}

partition([],[],[]).
partition([H|T],[H|P1],P2):-
	partition(T,P1,P2).
partition([H|T],P1,[H|P2]):-
	partition(T,P1,P2).

%partWrapper([],[]).
%partWrapper([H|T],[[H|T2]|P]):-
%	partition(T,T2,Res),
%	partWrapper(Res,P).

%solution(l1l2...ln)=[p1,p2],where partition(l,p1,p2), if checkCondTwoLists(p1,p2)

solution(L,[P1|[P2]]):-
	partition(L,P1,P2),
	checkCondTwoLists(P1,P2).

allsol(L,Res):-
	findall(RPart,solution(L,RPart),Res).