%initial list and constant k; produce a list of division between all elems and k
%[2,4,6],k=2 => [1,2,3]

%divk(L-list,K-constant,LR-resulting list)
%flow model (i,i,i),(i,i,o)

divk([],_,[]).
divk([H|T],K,[HR|LR]):-
	HR is H div K,
	divk(T,K,LR).
