%Given a list composed of only sublists that contain positive digits, write a SWI-Prolog program that
%computes the greatest even number that can be formed picking one digit from each sublist. The digits
%in the resulted number must be in the same order as in the sublists they come from. Each sublist will
%contain at least one even digit. For example, for the list [[2,5,1,9], [7,2,1], [9,4,6,5], [2,6,0,7]] the
%result will be 9796.

greatestEvenDigit([],0):-!.
greatestEvenDigit([H|T],H):-
	greatestEvenDigit(T,R),
	H mod 2 =:= 0,
	H>R,!.
greatestEvenDigit([_|T],R):-
	greatestEvenDigit(T,R).

greatestDigit([],0):-!.
greatestDigit([H|T],H):-
	greatestDigit(T,R),
	H>R,!.
greatestDigit([_|T],R):-
	greatestDigit(T,R).

reverseL([],R,R).
reverseL([H|T],R,RL):-
	reverseL(T,[H|R],RL).

%start with p=1
%constrNr(l1l2...ln,p)={greatestEvenDigit(l1),n=1
%			p*greatestDigit(l1)+constrNr(l2...ln,p*10),oth}

%flow model (i,i,o)
%constrNr([H],_,R):-
%	greatestEvenDigit(H,R),!.
%constrNr([H|T],P,R2):-
%	NewP is P*10,
%	constrNr(T,NewP,R),
%	greatestDigit(H,D),
%	R1 is P * D,
%	R2 is R1 + R.

%getDigitsList(l1l2...ln)={greatestEvenDigit(l1),n=1
%			greatestDigit(l1) U getDigitsList(l2...ln),oth}

getDigitsList([H],[R]):-
	greatestEvenDigit(H,R),!.
getDigitsList([H|T],[D|R]):-
	greatestDigit(H,D),
	getDigitsList(T,R).

%getNr(l1l2...ln,p)={l1*P,n=1
%			p*l1+getNr(p*10),oth}

getNr([H],P,R):-
	R is P*H,!.
getNr([H|T],P,R2):-
	NewP is P*10,
	getNr(T,NewP,R),
	R1 is P*H,
	R2 is R1+R.

sol(L,R):-
	getDigitsList(L,R1),
	reverseL(R1,[],R2),
	getNr(R2,1,R).