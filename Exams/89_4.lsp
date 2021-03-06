;Given a nonlinear list, write a Lisp function to return the list with all atoms on even levels
;replaced by zero. The superficial level is assumed 1. A MAP function shall be used.
;Example for the list (a (1 (2 b)) (c (d))) the result is (a (0 (2 b)) (0 (d))).

(defun repl (L lvl)
	(cond
		((and (atom L) (equal 0 (mod lvl 2))) 0)
		((atom L) L)
		(T (mapcar #'(lambda (A) (repl A (+ 1 lvl))) L))
))

(defun wrapperRepl (L)
	(repl L 0))