%11.b. Write a predicate to create the sublist (lm, …, ln) from the list (l1,…, lk).

%sublist(l1...lk,m,n,p)={[],n>p
%			l1+sublist(l2...lk,m,n,p+1), if m<p and p<n
%			sublist(l2...lk,m,n,p+1), otherwise}

%sublist(L-list,M-start position of sublist,N-end position of sublist,P-current position,LR-resulted list)
%flow model (i,i,i,i,i),(i,i,i,i,o)

sublist(_,_,N,P,[]):-
	P>N,!.
sublist([H|T],M,N,P,[H|LR]):-
	M=<P,
	P=<N,
	Newp is P+1,
	sublist(T,M,N,Newp,LR),!.
sublist([_|T],M,N,P,LR):-
	Newp is P+1,
	sublist(T,M,N,Newp,LR),!.

%valid positions test
%sublist([1,2,3,4,5,6,7],2,5,1,LR).
%LR = [2, 3, 4, 5].

%invalid positions test
%sublist([1,2,3,4,5,6,7],8,9,1,LR).
%false.
