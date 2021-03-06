;Given a nonlinear list, write a Lisp function to return the list with all even numerical atoms
;from an odd level removed. The superficial level is assumed 1. A MAP function shall be used.
;Example a) if the list is (1 (2 A (4 A)) (6)) => (1 (2 A (A)) (6))
;b) if the list is (1 (2 (C))) => (1 (2 (C)))

;rem(L,lvl)={nil,L number and L%2==0 and lvl%2==1
;			L,L atom
;			mapcar }

(defun remv (L lvl)
	(cond
		((and (numberp L) (eq 0 (mod L 2)) (eq 1 (mod lvl 2))) nil)
		((atom L) (list L))
		(T (list (apply #'append (mapcar #'(lambda (A) (remv A (+ 1 lvl))) L))))
))

(defun wrapRem (L)
	(car (remv L 0)))