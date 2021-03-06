;70_B
;Given a nonlinear list that contains both numerical and non-numerical atoms, write a Lisp program
;that builds a list that contains only numerical atoms, alternatively containing even and odd numbers.
;Odd numbers are each in a sublist. The even and odd numbers are in the same order relatively to the
;initial list. We assume that the initial list contains the same number of even and odd numbers. For
;example, for the list (A B (4 A 2 ) 11 (5 (A (B 20) C 10) (1(2(3(4)5)6)7 7) X Y Z)) the result will be 
;(4 (11) 2 (5) 20 (1) 10 (3) 2 (5) 4 (7) 6 (7)).

(defun getAllEven (L)
	(cond
		((null L) nil)
		((and (numberp (car L)) (equal 0 (mod (car L) 2))) (append (list(car L)) (getAllEven (cdr L))))
		((listp (car L)) (append (getAllEven (car L)) (getAllEven (cdr L))))
		(T (getAllEven (cdr L)))
))

(defun getAllOdd (L)
	(cond
		((null L) nil)
		((and (numberp (car L)) (equal 1 (mod (car L) 2))) (append (list(car L)) (getAllOdd (cdr L))))
		((listp (car L)) (append (getAllOdd (car L)) (getAllOdd (cdr L))))
		(T (getAllOdd (cdr L)))
))

(defun constrList (L1 L2)
	(cond
		((null L1) nil)
		(T (cons (car L1) (cons (list (car L2)) (constrList (cdr L1) (cdr L2)))))
))

(defun wrapperConstr (L)
	(constrList (getAllEven L) (getAllOdd L)))