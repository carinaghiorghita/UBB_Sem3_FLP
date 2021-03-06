;3.
;a) Write a function that inserts in a linear list a given atom A after the 2nd, 4th, 6th, ... element.
;b) Write a function to get from a given list the list of all atoms, on any
; level, but reverse order. Example:
; (((A B) C) (D E)) ==> (E D C B A)
;c) Write a function that returns the greatest common divisor of all numbers in a nonlinear list.
;d) Write a function that determines the number of occurrences of a given atom in a nonlinear list.

;3a

;insertA(l1l2...ln,p,A)={nil,n=0
;						l1+A+insertA(l2...ln,p+1,A),p%2==0
;						l1+insertA(l2...ln,p+1,A),otherwise}

;(1 2 3 4 5) -> (1 2 0 3 4 0 5)

;start with p=1
(defun insertA (L p A)
	(cond
		((null L) nil)
		((eq 0 (mod p 2)) (cons (car L) (cons A (insertA (cdr L) (+ 1 p) A))))
		(T (cons (car L) (insertA (cdr L) (+ 1 p) A)))
	)
)

;3b

;appendL(l1l2...ln,e)={[e],n=0
;						l1+appendL(l2...ln,e),otherwise}

(defun appendL (L e)
	(cond
		((null L) (list e))
		(T (cons (car L) (appendL (cdr L) e)))
	)
)

;reverseL(l1l2...ln)={[],n=0
;						reverseL(l2...ln)+reverseL(l1),l1 is list
;						appendL(reverseL(l2...ln),l1),otherwise}

(defun reverseL (L)
	(cond
		((null L) nil)
		((listp (car L)) (append (reverseL (cdr L)) (reverseL (car L))))
		(T (appendL (reverseL (cdr L)) (car L)))
	)
)

;3c

;gcdNr(a,b)={nil, a and b not number
;			a, b not number
;			b, a not number
;			a, b=0
;			gcd(b,a%b),otherwise}

(defun gcdNr (a b)
	(cond
		((and (not (numberp a)) (not (numberp b))) nil)
		((not (numberp a)) b)
		((not (numberp b)) a)
		((eq b 0) a)
		(T (gcdNr b (mod a b)))
))

;gcdL(l1l2...ln)={l1,n-1
;					gcdNr(gcdL(l1),gcd(l2...ln)),l1 is list
;					gcdNr(l1,gcdL(l2...ln)),otherwise}

(defun gcdL (L)
	(cond
		((and (atom (car L)) (null (cdr L))) (car L))
		((listp (car L)) (gcdNr (gcdL (car L)) (gcdL (cdr L))))
		(T (gcdNr (car L) (gcdL (cdr L))))
))

;3d

;nrOcc(l1l2...ln,e)={0,n=0
;					nrOcc(l1,e)+nrOcc(l2...ln,e),l1 is list
;					1+nrOcc(l2...ln,e),l1=e
;					nrOcc(l2...ln),otherwise}

(defun nrOcc (L e)
	(cond
		((null L) 0)
		((listp (car L)) (+ (nrOcc (car L) e) (nrOcc (cdr L) e)))
		((eq (car L) e) (+ 1 (nrOcc (cdr L) e)))
		(T (nrOcc (cdr L) e))
))