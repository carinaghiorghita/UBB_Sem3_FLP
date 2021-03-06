%Write a PROLOG program that generates the list of all subsets with values between the [a, b]
%interval such that the sum of elements from each subset is an odd value. Write the mathematical
%models and flow models for the predicates used. For example, for a=2 and b=4 ⇒
%[[2,3],[3,4],[2,3,4]] (not necessarily in this order).

%getElem(e,b)={e
%		getElem(e+1,b),e<b}

getElem(E,_,E).
getElem(E,B,Res):-
	E<B,
	NewE is E+1,
	getElem(NewE,B,Res).

exists([E|_],E):-!.
exists([_|T],E):-
	exists(T,E).


%solution(A,B,Sum,col1...coln)={col,Sum%2=1
%				solution(A,B,Sum+e,eUcol), where e=getElem(A,B)

%solution(A-int,B-int,Sum-sum,Col-list,Res-resulting list)

solution(_,_,Sum,Col,Col):-
	Sum mod 2 =:= 1.
solution(A,B,Sum,[H|Col],Res):-
	getElem(A,B,E),
	E<H,
	NewS is Sum+E,
	solution(A,B,NewS,[E,H|Col],Res).

wrapper(A,B,Res):-
	getElem(A,B,E),
	solution(A,B,E,[E],Res).

allsol(A,B,Res):-
	findall(RPart,wrapper(A,B,RPart),Res).
