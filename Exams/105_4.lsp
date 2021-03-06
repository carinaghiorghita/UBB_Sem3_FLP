;Given a nonlinear list, write a Lisp function to replace all even numerical values with their
;natural successor. A MAP function shall be used.
;Example for the list (1 s 4 (2 f (7))) the result is (1 s 5 (3 f (7))).

(defun succ (L)
	(cond
		((and (numberp L) (equal 0 (mod L 2))) (+ 1 L))
		((atom L) L)
		(T (mapcar #'succ L))
))