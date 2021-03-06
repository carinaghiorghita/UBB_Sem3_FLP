%4.
% a. Write a predicate to determine the sum of two numbers written in
% list representation.
% b. For a heterogeneous list, formed from integer numbers and list of
% digits, write a predicate to compute the sum of all numbers
% represented as sublists.
%Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].


%a.

%appendL(l1...ln,e)={[e], if n=0
%			l1+appendL(l2...ln,e), otherwise}

%appendL(L-list,E-int,RL-resulting list)
%flow model: (i,i,o)
%
appendL([],E,[E]).
appendL([H|T],E,[H|RL]):-
	appendL(T,E,RL).


%invertL(l1...l2)={[],if n=0
%		append(invertL(l2...ln),l1),otherwise}

%invertL(L-list,RL-resulting list)
%flow model: (i,o)

invertL([],[]).
invertL([H|T],RL):-
	invertL(T,IRL),
	appendL(IRL,H,RL).

%sum(a1...an,b1...bm,c)={[],if n=0 and m=0 and c=0
%			[1],if n=0 and m=0 and c=1
%			(b1+c)+sum([],b2...bm,0),if n=0 and b1+c<10
%			((b1+c)%10)+sum([],b2...bm,1),if n=0 and b1+c>=10
%			(a1+c)+sum(a2...an,[],0),if m=0 and a1+c<10
%			((a1+c)%10)+sum(a2...an,[],0),if m=0 and a1+c>=10
%			(a1+b1+c)+sum(a2...an,b2...bm,0),if a1+b1+c<10
%			((a1+b1+c)%10)+sum(a2...an,b2...bm,0),if a1+b1+c>=10}

%sum(A-list,B-list,C-int,RL-resulting list)
%flow model: (i,i,i,o)

sum([],[],0,[]).
sum([],[],1,[1]).
sum([],[H|B],C,[HRL|RL]):-
	%HRL is (H+C) mod 10,
	%HRL-H-C=:=0,
	HRL is H+C,
	HRL<10,
	sum([],B,0,RL).
sum([],[H|B],C,[HRL|RL]):-
	%HRL is (H+C) mod 10,
	%HRL-H-C=\=0,
	HRL2 is H+C,
	HRL2>=10,
	HRL is HRL2 mod 10,
	sum([],B,1,RL).
sum([H|A],[],C,[HRL|RL]):-
	%HRL is (H+C) mod 10,
	%HRL-H-C=:=0,
	HRL is H+C,
	HRL<10,
	sum(A,[],0,RL).
sum([H|A],[],C,[HRL|RL]):-
	%HRL is (H+C) mod 10,
	%HRL-H-C=\=0,
	HRL2 is H+C,
	HRL2>=10,
	HRL is HRL2 mod 10,
	sum(A,[],1,RL).
sum([HA|A],[HB|B],C,[HRL|RL]):-
	%HRL is (HA+HB+C) mod 10,
	%HRL-HA-HB-C=:=0,
	HRL is HA+HB+C,
	HRL<10,
	sum(A,B,0,RL).
sum([HA|A],[HB|B],C,[HRL|RL]):-
	%HRL is (HA+HB+C) mod 10,
	%HRL-HA-HB-C=\=0,
	HRL2 is HA+HB+C,
	HRL2>=10,
	HRL is HRL2 mod 10,
	sum(A,B,1,RL).

%sum_lists(a1...an,b1...bm)={a1...an,if m=0
%				b1...bm,if n=0
%				invert(sum(invert(a1...an),invert(b1...bm),0)),otherwise}

%sum_lists(A-list,B-list,RL-resulting list)
%flow model: (i,i,o)

sum_lists(A,[],A).
sum_lists([],B,B).
sum_lists(A,B,RL):-
	invertL(A,RA),
	invertL(B,RB),
	sum(RA,RB,0,RS),
	invertL(RS,RL),!.

%test cases:
%when n>m:sum_lists([1,2,3,4,5,6],[7,8,9],RL).
%when n<m:sum_lists([4,5,6],[2,3,8,6],RL).
%when there is a carry:sum_lists([4,5,6],[2,3,8,6],RL).
%when there is no carry:sum_lists([4,5,6],[1,2,3],RL).


%b

%heterListSum(l1...ln)={[],if n=0
%			sum_lists(l1,heterListSum(l2...ln)),if l1 is a list
%			heterListSum(l2...ln),otherwise}

%heterListSum(L-list,RL-resulting list)
%flow model: (i,o)

heterListSum([],[]).
heterListSum([H|T],RL):-
	is_list(H),
	heterListSum(T,R),
	sum_lists(H,R,RL),!.
heterListSum([_|T],RL):-
	heterListSum(T,RL),!.

%test cases:
%no sublist inside heterogenous list:heterListSum([1,2,3,4],RL).
%normal heterogenous list:heterListSum( [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] ,RL).

%even([H|T],RL):-
%	H mod 2 =:=0.
