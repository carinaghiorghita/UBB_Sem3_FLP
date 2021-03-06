;replaceWithZero on level k

(defun replaceWithZero (L k lvl)
	(cond
		((and (atom L) (eq k lvl)) 0)
		((atom L) L)
		(T (mapcar #'(lambda (A) (replaceWithZero A K (+ 1 lvl))) L))
))
