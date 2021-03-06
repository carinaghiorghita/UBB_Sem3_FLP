;Given a nonlinear list that contains numerical and non-numerical atoms, write a Lisp program that
;verifies if the sequence of the numerical atoms on all odd levels form a zig-zag sequence (element 2 is
;greater than the first element, element 3 is smaller than element 2, element 4 is greater than element 3, etc.). 
;For example, for the list (10 21 (3 A (B (0 77) 1 77)) C (5 (D 54) 11 6) 89 F H) the result will
;be true (the zig-zag sequence is (10 21 1 77 54 89)).

;keepAllNumOnOdd(l1...ln,lvl)={[],n=0
;								l1+keepAllNumOnOdd(l2...ln,lvl+1),lvl%2=1 and l1 numeric
;								keepAllNumOnOdd(l2...ln,lvl+1),oth}

;start with lvl=1
(defun keepAllNumOnOdd (L lvl)
	(cond
		((null L) nil)
		((and (numberp (car L)) (equal 1 (mod lvl 2))) (append (list (car L)) (keepAllNumOnOdd (cdr L) lvl)))
		((listp (car L)) (append (keepAllNumOnOdd (car L) (+ 1 lvl)) (keepAllNumOnOdd (cdr L) lvl)))
		(T (keepAllNumOnOdd (cdr L) lvl))
))

;ok=1 means l1<l2>l3; ok=0 means l1>l2<l3
;checkZigZag(l1...ln,ok)={true,n=3,ok=1 and l1<l2>l3
;							true,n=3,ok=0 and l1>l2<l3
;							false,ok=1 and l1>l2 or l3>l2
;							false,ok=0 and l1<l2 or l3<l2
;							checkZigZag(l2...ln,1-ok),oth}

;start with ok=1
(defun checkZigZag (L ok)
	(cond 
		((and (null (cadddr L)) (eq 1 ok) (< (car L) (cadr L)) (< (caddr L) (cadr L))) T)
		((and (null (cadddr L)) (eq 0 ok) (> (car L) (cadr L)) (> (caddr L) (cadr L))) T)
		((and (eq 1 ok) (or (> (car L) (cadr L)) (> (caddr L) (cadr L)))) nil)
		((and (eq 0 ok) (or (< (car L) (cadr L)) (< (caddr L) (cadr L)))) nil)
		(T (checkZigZag (cdr L) (- 1 ok)))
))

(defun wrapperZigZag (L)
	(checkZigZag (keepAllNumOnOdd L 1) 1))