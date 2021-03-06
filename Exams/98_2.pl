%98_B

gcdNr(A,0,A):-!.
gcdNr(A,B,R):-
	NewB is A mod B,
	gcdNr(B,NewB,R).

%start with i=2
%relativelyPrime(a,b)={true,gcdNr(a,b)=1
%			false,oth}

relativelyPrime(A,B):-
	gcdNr(A,B,R),
	R =:= 1.

relPrimeNrList([],_):-!.
relPrimeNrList([H|T],E):-
	relativelyPrime(H,E),
	relPrimeNrList(T,E).

relPrimeList([_]):-!.
relPrimeList([H|T]):-
	relPrimeNrList(T,H),
	relPrimeList(T).