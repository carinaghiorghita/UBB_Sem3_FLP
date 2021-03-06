%B. Given a linear list of numbers, write a SWI-Prolog program that replaces every sequence of
%consecutive equal numbers with the sum of the sequence. This process must be repeated until there
%are no consecutive equal elements in the list. For example, for the list
%[1, 2 , 1, 1, 4, 5, 6, 7, 7, 7, 3, 3, 3, 3, 3, 3, 3, 10], the result will be [1, 8, 5, 6, 42, 10].
%[1,2,2,4,5,6,21,21,10]

%checkCond(l1...ln)={true,n=1
%			false,l1=l2
%			checkCond(l2...ln),oth}

checkCond([_]):-!.
checkCond([H1,H2|T]):-
	H1=\=H2,
	checkCond([H2|T]).

%getNrConsec(l1l2...ln,ok)={1,ok=1 and l1!=l2
%				0,n=1&ok=0
%				1,n=1&ok=1
%				1+getNrConsec(l2...ln,1),l1=l2
%				getNrConsec(l2...ln,0),oth}

getNrConsec([H1,H2|_],1,1):-
	H1=\=H2,!.
getNrConsec([_],0,0):-!.
getNrConsec([_],1,1):-!.
getNrConsec([H1,H2|T],_,R):-
	H1=:=H2,!,
	getNrConsec([H2|T],1,R1),
	R is R1+1.
getNrConsec([_,H2|T],0,R):-
	getNrConsec([H2|T],0,R).

%deleteConsec(l1l2...ln,ok)={[],n=0
%				[],n=1&ok=1
%				l2...ln,ok=1,l1!=l2
%				l1+deleteConsec(l2...ln,0),ok=0,l1!=l2
%				deleteConsec(l2...ln,1),l1=l2

deleteConsec([],_,[]):-!.
deleteConsec([_],1,[]):-!.
deleteConsec([H1,H2|T],1,[H2|T]):-
	H1=\=H2,!.
deleteConsec([H1,H2|T],0,[H1|R]):-
	H1=\=H2,!,
	deleteConsec([H2|T],0,R).
deleteConsec([H1,H2|T],_,R):-
	H1=:=H2,!,
	deleteConsec([H2|T],1,R).

%replaceSeqWithSum(l1...ln,ok,S)={[],n=0
%				[S+H],n=1&ok=1
%				(S+l1)Ul2...ln,ok=1,l1!=l2
%				l1+deleteConsec(l2...ln,0,S),ok=0,l1!=l2
%				deleteConsec(l2...ln,1,S+l1),l1=l2

replaceSeqWithSum([],_,_,[]):-!.
replaceSeqWithSum([H],1,S,[NewS]):-!,
	NewS is S+H.
replaceSeqWithSum([H1,H2|T],1,S,[NewS,H2|T]):-
	H1=\=H2,!,
	NewS is S+H1.
replaceSeqWithSum([H1,H2|T],0,S,[H1|R]):-
	H1=\=H2,!,
	replaceSeqWithSum([H2|T],0,S,R).
replaceSeqWithSum([H1,H2|T],_,S,R):-
	H1=:=H2,!,
	NewS is S+H1,
	replaceSeqWithSum([H2|T],1,NewS,R).

%sol(L)=sol(replaceSeqWithSum(L,0,0)),if !checkCond(L)

sol(L,L):-
	checkCond(L),!.
sol(L,RL):-
	replaceSeqWithSum(L,0,0,R),
	sol(R,RL).


%sum of digits
sumDigits(N,N):-
	N<10,!.
sumDigits(N,R):-
	D is N mod 10,
	N1 is N - D,
	N2 is N1 / 10,
	sumDigits(N2,R1),
	R is R1+D.