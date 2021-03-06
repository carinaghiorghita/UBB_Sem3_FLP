%Permutations of n

%candidate(n)={n
%		candidate(n-1),n>1

candidate(N,N).
candidate(N,R):-
	N>1,
	NewN is N-1,
	candidate(NewN,R).

exists([E|_],E).
exists([_|T],E):-
	exists(T,E).

perm(N,N,Col,Col).
perm(N,K,Col,RL):-
	candidate(N,E),
	\+exists(Col,E),
	NewK is K+1,
	perm(N,NewK,[E|Col],RL).

permWrap(N,RL):-
	candidate(N,E),
	perm(N,1,[E],RL).

allsol(N,RL):-
	findall(RPart,permWrap(N,RPart),RL).

%Combinations of n taken k

comb(_,0,Col,Col).
comb(N,K,[H|Col],RL):-
	candidate(N,E),
	E<H,
	\+exists([H|Col],E),
	K1 is K-1,
	comb(N,K1,[E,H|Col],RL).

combWrap(N,K,RL):-
	candidate(N,E),
	K1 is K-1,
	comb(N,K1,[E],RL).

%Subsets of n

subm(_,Col,Col).
subm(N,[H|Col],RL):-
	candidate(N,E),
	E<H,
	\+exists([H|Col],E),
	subm(N,[E,H|Col],RL).

submWrap(N,RL):-
	candidate(N,E),
	subm(N,[E],RL).

getMaxList([],0).
getMaxList([H|T],H):-
	getMaxList(T,R),
	H>R,!.
getMaxList([_|T],R):-
	getMaxList(T,R).

getMinList([],9999).
getMinList([H|T],H):-
	getMinList(T,R),
	H<R,!.
getMinList([_|T],R):-
	getMinList(T,R).
