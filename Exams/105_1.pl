f2([],-1):-!.
f2([H|T],Rez):-f2(T,S),f_aux([H|T],S,Rez).

f_aux([_|T],S,Rez):-S<1,!,Rez is S+2.
f_aux([H|T],S,Rez):-S<0,!,Rez is S+H.
f_aux([_|T],S,Rez):-Rez is S.