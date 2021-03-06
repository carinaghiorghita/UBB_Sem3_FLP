;7. Write a function that substitutes an element E with all elements of a list L1 at all levels of a given list L.

;replaceWithList(L,E,L1)={L1, L is atom and L=E
;							L, L is atom
;							U i=1,n replaceWithList(L_i)}

(defun replaceWithList (L E L1)
	(cond
		((and (atom L) (equal L E)) L1)
		((atom L) L)
		(T (mapcar #'(lambda (A) (replaceWithList A E L1)) L))
))