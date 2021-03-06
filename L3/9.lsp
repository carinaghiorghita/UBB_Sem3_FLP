;9. Write a function that removes all occurrences of an atom from any level of a list.

;removeOcc(l1l2...ln,e)={nil,l1 atom and l1=e
;						l1, l1 atom
;						U i=1,n (removeOcc(l_i))}

(defun removeOccMap (L e)
	(cond
		((and (atom L) (equal e L)) nil)
		((atom L) L)
		(T (mapcar #'(lambda (A) (removeOcc A e)) L))
))
