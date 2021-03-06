%For a list a1... an with integer and distinct numbers, define a predicate to determine all subsets with
%sum of elements divisible with k.

%candidate(l1...ln)={(l1,l2l3...ln)
%		     (e,l1 U list),(e,list)=candidate(l2...ln)}

%candidate(L-list,E-element,RL-list)
%flow model: (i,o,o)

candidate([H|T],H,T).
candidate([H|T],E,[H|RL]):-
	candidate(T,E,RL).

% solution(l1...ln,k,S,col1...colm)={solution(list,k,S+e,e U col),
%				     (e,list)=candidate(l1...ln),e<col1
%				     col,S%k=0}

%solution(L-list,K-integer,S-integer,Col-list,RL-resulting list)
%flow model: (i,i,i,i,o)

solution(_,K,S,Col,Col):-
	S mod K =:= 0.
solution(L,K,S,[H|Col],RL):-
	candidate(L,E,List),
	E < H,
	S1 is S+E,
	solution(List,K,S1,[E,H|Col],RL).

% solution_wrapper(l1...ln,k)=solution(list,k,e,[e]),(e,list)=candidate(l1...ln)

%sol(L-list,K-int,RL-resulting list)
%flow model: (i,i,i,o)

solution_wrapper(L,K,RL):-
	candidate(L,E,List),
	solution(List,K,E,[E],RL).
%allsol(l1...ln,k)= U solution_wrapper(l1...ln,k)


%allsol(L-list,K-int,RL-resulting list)
%flow model: (i,i,o)

allsol(L,K,RL):-
	findall(Rpart,solution_wrapper(L,K,Rpart),RL).


%tests:
%allsol([1,2,3,4],3,RL). -> [[1,2], [3], [1,2,3], [2,4], [2,3,4]]

%allsol([],3,RL). -> []

%allsol([2],3,RL). -> []

%allsol([1,2,3,4,5,6,7],3,RL),write(RL).
