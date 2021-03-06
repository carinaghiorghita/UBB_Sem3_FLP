%start with i=2
%checkNrPrime(X,i)={true,i*i>x
%			false,X%i=0
%			checkNrPrime(X,i+1),otherwise}

checkNrPrime(X,I):-
	X mod I =:= 0,
	fail.
checkNrPrime(X,I):-
	X < I*I,!.
checkNrPrime(X,I):-
	X mod I =\= 0,
	I*I < X,!,
	NewI is I+1,
	checkNrPrime(X,NewI).

%getProperDiv(X,i)={[],i*i>x
%			iUgetProperDiv(X,i+1),X%i=0
%			getProperDiv(X,i+1),oth}

getProperDiv(X,I,[]):-
	I*I > X,!.
getProperDiv(X,I,[I|RL]):-
	X mod I =:= 0,
	I =:= X/I,!,
	NewI is I+1,
	getProperDiv(X,NewI,RL).
getProperDiv(X,I,[I,I2|RL]):-
	X mod I =:= 0,
	I =\= X/I,!,
	NewI is I+1,
	I2 is X/I,
	getProperDiv(X,NewI,RL).
getProperDiv(X,I,RL):-
	NewI is I+1,
	getProperDiv(X,NewI,RL).

%sumList(l1...ln)={0,n=0
%			l1+sumList(l2...ln),oth}

sumList([],0).
sumList([H|T],S):-
	sumList(T,SPart),
	S is H+SPart.

%primeList(l1l2..ln)={true,n=0
%			false,!checkNrPrime(l1)
%			primeList(l2..ln),oth}

primeList([]).
primeList([H|_]):-
	\+checkNrPrime(H,2),
	fail.
primeList([H|T]):-
	checkNrPrime(H,2),
	primeList(T).

%replWithSum(l1l2...ln)={[],n=0
%			sumList(getProperDiv(l1)) U replWithSum(l2...ln), !checkNrPrime(l1)
%			replWithSum(l2...ln),otherwise}

replWithSum([],[]):-!.
replWithSum([H|T],[S|RL]):-
	\+checkNrPrime(H,2),!,
	getProperDiv(H,2,R1),
	sumList(R1,S),
	replWithSum(T,RL).
replWithSum([H|T],[H|RL]):-
	checkNrPrime(H,2),!,
	replWithSum(T,RL).

%solution(l1...ln,r)={r,primeList(l)
%			solution(replWithSum(l)),oth}

solution(L,Res,Res):-
	primeList(L),!.
solution(L,_,Res):-
	\+primeList(L),!,
	replWithSum(L,R),
	solution(R,R,Res).

solWrapper(L,Res):-
	solution(L,L,Res).
