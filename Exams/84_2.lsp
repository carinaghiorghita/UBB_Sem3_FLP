;Given a nonlinear list containing numerical and non-numerical atoms, write a LISP program that
;verifies if the numerical atoms in the list form an increasing sequence. For example, for the list 
;(A B 1 (2 C D) 3 4 (F T 6 10 (A E D) (34) F) 111) the result will be true (T), and for the list 
;(A B 1 (2 C D) 3 4 (F T 6 1 (A E D) (34) F) 111) the result will be false (NIL).

(defun getAllNumerical (L)
	(cond
		((numberp L) (list L))
		((atom L) nil)
		(T (mapcan #'getAllNumerical L))
))

(defun checkIncr (L)
	(cond
		((null (cdr L)) T)
		((> (car L) (cadr L)) nil)
		(T (checkIncr (cdr L)))
))

(defun sol (L)
	(checkIncr (getAllNumerical L))
)