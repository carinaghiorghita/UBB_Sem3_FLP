;12. Determine the list of nodes accesed in preorder in a tree of type (2).
;preorder: root left right

;preorder(l1l2l3)={nil,l is null
;					l1+preorder(l2)+preorder(l3),otherwise}

(defun preorder (L)
	(cond
		((null L) nil)
		(T (append (list (car L)) (append (preorder (cadr L)) (preorder (caddr L)))))
))
