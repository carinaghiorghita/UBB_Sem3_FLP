%11.a. Write a predicate to substitute an element from a list with another element in the list.

%subst(l1...ln,e1,e2)={[], if n=0
%			e2+subst(l2...ln,e1,e2), if l1=e1
%			l1+subst(l2...ln,e1,e2), otherwise}

%subst(L-list,E1-int,E2-int,LR-resulting list)
%flow model (i,i,i,i),(i,i,i,o)

subst([],_,_,[]):-!.
subst([E1|T],E1,E2,[E2|LR]):-
	%H=:=E1,
	subst(T,E1,E2,LR),!.
subst([H|T],E1,E2,[H|LR]):-
	%H=\=E1,
	subst(T,E1,E2,LR),!.

%existing element replaced
%?- subst([1,2,3,1,4,1,6],1,0,LR).
%LR = [0, 2, 3, 0, 4, 0, 6].

%nonexistent element replaced - nothing changes
%?- subst([1,2,3,1,4,1,6],7,8,LR).
%LR = [1, 2, 3, 1, 4, 1, 6].

%empty list
%?- subst([],1,0,LR).
%LR = [].
