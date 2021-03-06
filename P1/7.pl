%7.a. Write a predicate to compute the intersection of two sets.
%b. Write a predicate to create a list (m, ..., n) of all integer numbers from the interval [m, n].

%7a
%exists(e,l1l2...ln)={false,n=0
%			true,e=l1
%			exists(e,l2...ln),otherwise}

%exists(E-elem,L-list)
%flow model (i,i)

exists(E,[E|_]):-!.
exists(E,[_|T]):-
	exists(E,T).

%inters(a1a2...an,b1b2...bm)={[],n=0
%				a1+inters(a2...an,b1b2...bm),exists(a1,b1b2...bm)
%				inters(a2...an,b1b2...bm),otherwise}

%inters(A-list,B-list,RL-resulting list)
%flow model: (i,i,o)

inters([],_,[]).
inters([HA|TA],B,[HA|T]):-
	exists(HA,B),
	inters(TA,B,T),!.
inters([_|TA],B,RL):-
	inters(TA,B,RL).


%7b
%crList(m,n)={[],m>n
%		m+crList(m+1,n),otherwise}

%crList(M-int,N-int,RL-res list)
%flow model (i,i,o)

crList(M,N,[]):-M>N,!.
crList(M,N,[M|RL]):-
	NewM is M+1,
	crList(NewM,N,RL).
