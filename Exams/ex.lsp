(defun rev (L)
	(cond 
		((null L) NIL)
		(T (append (rev (cdr L)) (list (car L))))
	)
)

(defun countList (L)
	(cond
		((atom L) 0)
		((not (numberp (car L))) (+ 1 (apply #'+ (mapcar #'countList (rev L)))))
		(t (apply #'+ (mapcar #'countList (rev L))))
	)
)

(defun mainWrap (L)
	(countList (rev L))
)

;(print '(mainWrap '(A (B 2) (1 C 4) (D 1 (6 F)) ((G 4) 6) F)))