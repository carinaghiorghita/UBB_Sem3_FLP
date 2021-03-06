;;;;4.Write a function that returns the product of numeric atoms in a list, at any level.

;;;numProd(n)={n, n is a number
;;;				1, n is an atom
;;;				Π i=1,k numProd(n_i), otherwise}

(defun numProd (n)
	(cond
		((numberp n) n)
		((atom n) 1)
		(T (apply #'* (mapcar #'numProd n)))
	)
)

;;;(load "D:\\fac\\sem3\\plf\\L3.lsp")

;;;Tests:
;;;(numProd 3) -> 3
;;;(numProd 'A) -> 1
;;;(numProd '()) -> 1
;;;(numProd '(1 2 3)) -> 6
;;;(numProd '(A B C)) -> 1
;;;(numProd '(A 3 B C 2 4)) -> 24
;;;(numProd '(A 3 B (C 1) 2 4 (3 (F 5)))) -> 360