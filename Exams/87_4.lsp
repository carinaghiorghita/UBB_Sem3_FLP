;87_D
;Given a nonlinear list, write a Lisp function to return the list with all occurrences of the element
;e replaced by the value e1. A MAP function shall be used.
;Example a) if the list is (1 (2 A (3 A)) (A)), e is A and e1 is B => (1 (2 B (3 B)) (B))
;b) if the list is (1 (2 (3))) and e is A => (1 (2 (3)))

(defun repl (L E E1)
	(cond
		((and (atom L) (equal L E)) E1)
		((atom L) L)
		(T (mapcar #'(lambda (A) (repl A E E1)) L))
))