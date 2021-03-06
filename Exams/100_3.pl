%For a given value N, generate the list of all permutations with elements N, N+1, ..., 2*N-1
%with the property that the absolute value between two consecutive values from the permutation
%is <=2. Write the mathematical models and flow models for the predicates used.

%getElement(E,N)={E
%		getElement(E+1,N),E<2*N}

%getElement(E-int,N-int,Res-result)
%flow model (i,i,o)

getElement(E,_,E).
getElement(E,N,Res):-
	E < N*2,
	E1 is E+1,
	getElement(E1,N,Res).

%exists(L,E)

exists([E|_],E):-!.
exists([_|T],E):-
	exists(T,E).

%candidate(l1l2...ln,n)=e, where e=getElement(n,n) if not exists(l1l2...ln,e)

candidate(L,N,E):-
	getElement(N,N,E),
	\+exists(L,E).

%solution(L,N,Len,Res)

solution(L,N,Len,L):-
	Len =:= N+1.
solution([H|T],N,Len,Res):-
	candidate([H|T],N,R),
	abs(H - R) =< 2,
	Len2 is Len+1,
	solution([R,H|T],N,Len2,Res).

%permutation(N,Res)

permutation(N,Res):-
	candidate([],N,E),
	solution([E],N,1,Res).

wrapper(N,Res):-
	findall(ResP,permutation(N,ResP),Res).