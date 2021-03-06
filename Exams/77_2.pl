%77_B
%Given a numerical linear list, write a SWI-Prolog program that builds a list of lists such that: the first
%element is the initial list, and then, each element is represented by the previous list in which the
%increasing sequences of numbers were reversed. The last element of the list will be the list in which all
%elements are sorted increasingly. For example, for the list [1,3,6,5,2] the result will be: [[1, 3, 6, 5, 2],
%[6, 3, 1, 5, 2], [6, 3, 5, 1, 2], [6, 5, 3, 2, 1]].

%reverseL(l1l2...ln)={[],n=0
%			l1+reverseL(l2...ln),oth}

%flow model(i,i,o)

reverseL([],R,R).
reverseL([H|T],R,RL):-
	reverseL(T,[H|R],RL).
%[1, 3, 6, 5, 2] -> [1,3,6]
%[7, 1, 3, 6] -> [1,3,6]
%getIncrSublist(l1l2...ln,ok)={[l1],ok=1,l1>=l2
%				[l1],n=1,ok=1
%				[],n=1,ok=0
%				getIncrSublist(l2...ln,0),l1>=l2,ok=0
%				l1 U getIncrSublist(l2...ln,1),l1<l2}

getIncrSublist([H],1,[H]):-!.
getIncrSublist([_],0,[]):-!.
getIncrSublist([H1,H2|_],1,[H1]):-
	H1 >= H2,!.
getIncrSublist([H1,H2|T],0,RL):-
	H1 >= H2,!,
	getIncrSublist([H2|T],0,RL).
getIncrSublist([H1,H2|T],_,[H1|RL]):-
	getIncrSublist([H2|T],1,RL).

addListToList2([],B,B).
addListToList2([HA|A],B,[HA|RL]):-
	addListToList2(A,B,RL).

%getEverythingButIncrSublist(l1l2...ln,ok)={l2...ln,ok=1,l1>=l2
%					[],n=1,ok=1
%					[],n=0
%					l1+getEverythingButIncrSublist(l2...ln,0),l1>=l2,ok=0
%					reverse(getIncrSublist(L,0)) U getEverythingButIncrSublist(l2...ln,1),l1<l2,ok=0}

getEverythingButIncrSublist([_],1,[]):-!.
getEverythingButIncrSublist([],_,[]):-!.
getEverythingButIncrSublist([H1,H2|T],1,[H2|T]):-
	H1 >= H2,!.
getEverythingButIncrSublist([H1,H2|T],0,[H1|RL]):-
	H1 >= H2,!,
	getEverythingButIncrSublist([H2|T],0,RL).
getEverythingButIncrSublist([H1,H2|T],0,R):-
	H1<H2,!,
	getIncrSublist([H1,H2|T],0,R1),
	reverse(R1,R2),
	getEverythingButIncrSublist([H2|T],1,RL),
	addListToList2(R2,RL,R).
getEverythingButIncrSublist([_,H2|T],1,RL):-
	getEverythingButIncrSublist([H2|T],1,RL).

%checkIncr(l1...ln)={false,n=1
%			true,l1<l2
%			checkIncr(l2...ln),oth}

checkIncr([_]):-fail.
checkIncr([H1,H2|_]):-
	H1<H2,!.
checkIncr([_|T]):-
	checkIncr(T).

solIncr(L,[L]):-
	\+checkIncr(L),!.
solIncr(L,[L|RL]):-
	getEverythingButIncrSublist(L,0,R),
	solIncr(R,RL).
