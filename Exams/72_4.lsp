;An n-ary tree is represented in Lisp as ( node subtree1 subtree2 ...).. Write a function to return
;the list of nodes on even levels, in increasing level order (0, 2, …). The root level is assumed
;zero. A MAP function shall be used.
;Example for the tree (a (b (g)) (c (d (e (h))) (f))) => (a g d f h)

;nu e in ordinea nivelelor

(defun nodesEvenLvl (L lvl)
	(cond
		((and (atom L) (equal 0 (mod lvl 2))) (list L))
		((atom L) nil)
		(T (mapcan #'(lambda (A) (nodesEvenLvl A (+ 1 lvl))) L))
))
