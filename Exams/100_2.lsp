;Given a nonlinear list containing both numerical and non-numerical atoms, write a LISP program
;that computes the greatest common divisor of the numbers situated between two non-numerical atoms
;(neighbours of a number are not level dependent). For example, for the list 
;(A B 12 (5 D (A F (15 B) D (5 F) 4)) C 9) the numbers for which we need to compute the greatest common divisor are: 
;15 (between F and B), 5 (between D and F) and 4 (between F and C), and the result will be 60. You are
;not allowed to use the predefined gcd Lisp function.

;linearize(l1l2...ln)={[],n=0
;						linearize(l1)+linearize(l2..ln),l1 is list
;						l1+linearize(l2...ln),otherwise}

(defun linearize (L)
	(cond
		((null L) nil)
		((listp (car L)) (append (linearize (car L)) (linearize (cdr L))))
		(T (append (list (car L)) (linearize (cdr L))))
))

;(A B 12 5 D A F 15 B D 5 F 4 C 9)

;nrBetweenNonnum(l1l2...ln)={[],n<3
;							[],n=3 and l2 not number or l1,l3 not nonnum
;							l2+nrBetweenNonnum(l2...ln),if l2 number and l1,l3 nonnum
;							nrBetweenNonnum(l2...ln),otherwise}

(defun nrBetweenNonnum (L)
	(cond
		((null (caddr L)) nil)
		((and (null (cadddr L)) (or (not (numberp (cadr L))) (and (not (numberp (car L))) (not (numberp (caddr L)))))) nil)
		((and (numberp (cadr L)) (not (numberp (car L))) (not (numberp (caddr L)))) (append (list (cadr L)) (nrBetweenNonnum (cdr L))))
		(T (nrBetweenNonnum (cdr L)))
))

;gcdTwoNr(a,b)={a,b=0
;				gcd(b,a%b), otherwise}

(defun gcdTwoNr (a b)
	(cond
		((equal b 0) a)
		(T (gcdTwoNr b (mod a b)))
))
;lcmTwoNr=a*b/gcdTwoNr(a,b)
(defun lcmTwoNr (a b)
	(/ (* a b) (gcdTwoNr a b)))

;lcmList(l1l2...ln)={l1,n=1
;					lcmTwoNr(l1,lcmList(l2...ln)),otherwise}

(defun lcmList (L)
	(cond
		((null (cdr L)) (car L))
		(T (lcmTwoNr (car L) (lcmList (cdr L))))
))

(defun wrapper (L)
	(lcmList (nrBetweenNonnum (linearize L))))