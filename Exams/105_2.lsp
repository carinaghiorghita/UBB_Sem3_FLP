;Given a nonlinear list that contains numerical and non-numerical atoms, write a LISP program that
;builds a list that has the same structure as the initial list, but each (sub)list contains a single element
;on the superficial level, and that element is computed as the difference between the maximum and the
;minimum values on the superficial level of the corresponding (sub)list in the initial list. It is guaranteed
;that each (sub)list contains at least a numerical atom. For example, for the list 
;(F A 12 13 (B 11 (A D 15) C 3 C (1 F 6) 1) 18 11 D (A 7 F 9) F) the result will be (7 (10 (0) (5)) (2)) 
;(7 is the difference between 18 and 11, 10 is the difference between 11 and 1, 0 is the difference between 15 and 15, etc.).

;idk dc imi gaseste minimul pe prima lista 12 in loc de 11 :(((


;findMax(l1l2...ln)={l1,n=1
;					l1,l1>findMax(l2...ln)
;					findMax(l2...ln),otherwise}

(defun findMax (L)
	(cond
		((null L) 0)
		((and (numberp (car L)) (> (car L) (findMax (cdr L)))) (car L))
		(T (findMax (cdr L)))
))

;findMin(l1l2...ln)={l1,n=1
;					l1,l1<finMin(l2...ln)
;					findMin(l2...ln),oth}

(defun findMin (L)
	(cond
		((null L) 9999)
		((and (numberp (car L)) (< (car L) (findMax (cdr L)))) (car L))
		(T (findMin (cdr L)))
	)
)

;ok=0 la incep de lista, l1 atom -> max(l)-min(l)Utransf(cdr L), ok=1
;ok=0, l1 lista -> max(l)-min(l)Utransf(L),ok=1
;ok=1, l1 atom -> transf(cdr L)
;ok=1, l1 lista -> transf(car L)U transf(cdr L)

(defun transf (L ok)
	(cond
		((null L) nil)
		((and (equal ok 0) (atom (car L))) (cons (- (findMax L) (findMin L)) (transf (cdr L) 1)))
		((and (equal ok 0) (listp (car L))) (cons (- (findMax L) (findMin L)) (transf L 1)))
		((and (equal ok 1) (atom (car L))) (transf (cdr L) 1))
		((and (equal ok 1) (listp (car L))) (cons (transf (car L) 0) (transf (cdr L) 1)))
))