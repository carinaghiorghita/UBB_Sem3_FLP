;;;;10. Return the level of a node X in a tree of type (2). The level of the root element is 0.

;;;levelNode(l1l2l3,e,lvl)={nil,l is null
;;;							lvl,l1=e
;;;							levelNode(l2,e,lvl+1) or levelNode(l3,e,lvl+1),otherwise}

(defun levelNode (l e lvl)
	(cond 
		((null l) nil)
		((equal (car l) e) lvl)
		(T (or (levelNode (cadr l) e (+ lvl 1)) (levelNode (caddr l) e (+ lvl 1))))
	)
)

;;;(load "D:\\fac\\sem3\\plf\\L2.lsp")

;;; !!! root is on level 0, so the parameter lvl is 0 !!!

;;;Tests:
;;;(levelNode '() 'A 0) -> NIL
;;;(levelNode '(A (B) (C (D) (E))) 'H 0) -> NIL
;;;(levelNode '(A (B) (C (D) (E))) 'A 0) -> 0
;;;(levelNode '(A (B (C (I) ()) (F (G) ())) (D (E) (H))) 'G 0) -> 3
;;;(levelNode '(F (A) (C (D) (A))) 'A 0) -> 1

