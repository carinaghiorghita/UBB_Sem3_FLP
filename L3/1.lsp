;1. Write a function to check if an atom is member of a list (the list is non-liniar)

;functie pt or

(defun orFunc (L)
	(cond
		((null L) nil)
		((car L) T)
		(T (orFunc (cdr L)))
))

;memberL(L,e)={nil,L atom and L!=e
;				true,L atom and L=e
;				U i=1,n memberL(L_i),otherwise}

(defun memberList (L e)
	(cond
		((and (atom L) (eq L e)) T)
		((atom L) nil)
		(T (apply #'orFunc (mapcar #'(lambda (L) (memberList L e)) l)))
))