%8.a. Write a predicate to determine if a list has even numbers of elements without counting the elements from the list.
%b. Write a predicate to delete first occurrence of the minimum number from a list.

%8a
%evenList(l1l2...ln)={true,n=0
%			false,n=1
%			evenList(l3...ln),otherwise}

%evenList(L-list)
%flow model (i)

evenList([]):-!.
evenList([_,_|T]):-
	evenList(T).

%8b
%minNr(a,b)]{a,a<=b
%		b,otherwise}

%minNr(A-int,B-int,M-min)
%flow model (i,i,o)

minNr(A,B,A):-
	A=<B,!.
minNr(_,B,B).

%findMin(l1l2...ln)={l1,n=1
%			minNr(l1,findMin(l2...ln)),otherwise}

%findMin(L-list,M-min)
%flow model (i,o)

findMin([H],H):-!.
findMin([H|T],M):-
	findMin(T,NewM),
	minNr(NewM,H,M).
%----------------------------
%deleteOcc(l1l2...ln,e)={[],n=0
%			deleteOcc(l2...ln),l1=e
%			l1+deleteOcc(l2...ln),otherwise

%deleteOcc(L-list,E-elem,RL-res list)
%flow model (i,i,o)

%deleteOcc([],_,[]).
%deleteOcc([E|T],E,T).
%deleteOcc(
%-----------------------------
%deleteFirstOcc(l1l2...ln,e)={l2...ln,l1=e
%				deleteFirstOcc(l2...ln,e),otherwise

%deleteFirstOcc(L-list,E-elem,RL-res list)
%flow model (i,i,o)

deleteFirstOcc([E|T],E,T):-!.
deleteFirstOcc([H|T],E,[H|RL]):-
	deleteFirstOcc(T,E,RL).

%deleteFirstMin(l1l2...ln)=deleteFirstOcc(l1l2...ln,findMin(l1l2...ln))

%deleteFirstMin(L-list,RL-resulting list)
%flow model (i,o)

deleteFirstMin(L,RL):-
	findMin(L,M),
	deleteFirstOcc(L,M,RL).
