f(100, 1):-!.
f(K,X):-K1 is K+1, f(K1,Y), Y>1, !, K2 is K1-1, X is K2+Y.
f(K,X):-K1 is K+1, f(K1,Y), Y>0.5, !, X is Y.
f(K,X):-K1 is K+1, f(K1,Y), X is Y-K1.

f2(100,1):-!.
f2(K,X):-K1 is K+1,f2(K1,Y),f_aux(K1,X,Y).

f_aux(K1,X,Y):-Y>1, !, K2 is K1-1, X is K2+Y.
f_aux(_,X,Y):-Y>0.5, !, X is Y.
f_aux(K1,X,Y):-X is Y-K1.
