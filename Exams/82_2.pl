%[13, 2, 9, 2, 5, 0, 3, 2, 11, 0, 6, 1, 3, 0, 2, 1, 7, 1, 9, 1, 8, 2, 4, 0, 2, 1, 10, 0]

%get left subtree

%traverse tree, keeping the level, sum and a list of already visited levels

%traverseLeft(l1l2...ln,v,m)={[],n=0
%				[],v=m+1
%				l1+l2+traverseLeft(l3...ln,v+1,m+l2),otherwise

%traverseLeft(L-tree,V-number of nodes,M-number of edges,RL-resulting left subtree)
%flow model (i,i,i,o),(i,o,o,o)

traverseLeft([],_,_,[]):-!.
traverseLeft(_,V,M,[]):-
	V =:= M+1,!.
traverseLeft([H1,H2|T],V,M,[H1,H2|RL]):-
	NewV is V+1,
	NewM is M+H2,
	traverseLeft(T,NewV,NewM,RL).

%leftSubt(l1l2...ln)=traverseLeft(l3...ln,0,0)

%leftSubt(L-tree,RL-left subtree)
%flow model (i,o)

leftSubt([_,_|T],RL):-
	traverseLeft(T,0,0,RL).

%get right subtree
%traverseRight(l1l2...ln,m,v)={[],n=0
%				l,v=m+1
%				traverseRight(l3...ln,v+1,m+l2),otherwise}

%traverseRight(L-tree,V-nodes,M-edges,RL-resulting right subtree)
%flow model (i,i,i,o)

traverseRight([],_,_,[]):-!.
traverseRight(L,V,M,L):-
	V =:= M+1,!.
traverseRight([_,H2|T],V,M,RL):-
	NewV is V+1,
	NewM is M+H2,
	traverseRight(T,NewV,NewM,RL).

%rightSubt(l1l2...ln)=traverseRight(l3...ln,0,0)

%rightSubt(L-tree,RL-right subtree)
%flow model (i,o)

rightSubt([_,_|T],RL):-
	traverseRight(T,0,0,RL).

%exists(l1l2...ln,e)={false,n=0
%			true,l1=e
%			exists(l2...ln,e),otherwise}

%flow model (i,i)

exists([H|_],H):-!.
exists([_|T],E):-
	exists(T,E).

%addListToList(a1a2...an,b1b2...bm)={b,n=0
%					a1+addListToList(a2...an,b1...bm),otherwise}

addListToList([],B,B):-!.
addListToList([HA|A],B,[HA|RL]):-
	addListToList(A,B,RL).

%getSum(l1l2...ln,lvl,sum,col)={sum,col, if n=0
%				getSum(leftSubt(l),lvl+1,sum+l1,lvl+col),getSum(rightSubt(l),lvl+1,sum+l1,lvl+col),if not exists(col,lvl)
%				getSum(leftSubt(l),lvl+1,sum,col),getSum(rightSubt(l),lvl+1,sum,col), otherwise}

% getSum(L-list, Lvl-current level, Sum-sum, Col-list of levels already
% parsed,FS-final su) flow model (i,i,o,o)

%!!! asta nu merge - need to add final sum maybe

getSum([],_,_,0):-!.
getSum([_,_|T],Lvl,Col,Sum):-
	exists(Col,Lvl),!,
	NewLvl is Lvl+1,
	leftSubt([_,_|T],RLL),
	rightSubt([_,_|T],RLR),
	getSum(RLL,NewLvl,Col,Sum1),
	getSum(RLR,NewLvl,Col,Sum2),
	Sum is Sum1+Sum2.
	%addListToList(C2,C2,C).
getSum([H,_|T],Lvl,Col,Sum):-
	\+exists(Col,Lvl),!,
	%write(Col),
	NewLvl is Lvl+1,
	leftSubt([H,_|T],RLL),
	rightSubt([H,_|T],RLR),
	getSum(RLL,NewLvl,[Lvl|Col],Sum1),
	getSum(RLR,NewLvl,[Lvl|Col],Sum2),
	S1 is Sum1+Sum2,
	Sum is S1+H.
	%addListToList(C1,C2,C).

%sumWrapper(L-tree,S-sum)

sumWrapper(L,S):-
	getSum(L,0,[],S).
