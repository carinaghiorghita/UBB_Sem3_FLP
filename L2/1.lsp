;1. For a given tree of type (1) return the path from the root node to a certain given node X.

;use functions from 2.lsp

(defun travLeft (L v m)
	(cond
		((null L) nil)
		((= v (+ 1 m)) nil)
		(T (cons (car L) (cons (cadr L) (travLeft (cddr L) (+ 1 v) (+ (cadr L) m)))))
))

(defun leftSubt (L)
	(travLeft (cddr L) 0 0)
)

(defun travRight (L v m)
	(cond
		((null L) nil)
		((eq v (+ 1 m)) L)
		(T (cadr L) (travRight (cddr L) (+ 1 v) (+ (cadr L) m)))
))

(defun rightSubt (L)
	(travRight (cddr L) 0 0)
)
;appears(l1l2...ln,e)={nil,n=0
;					true,l1=e
;					appears(leftSubt(l)) or appears(rightSubt(l))}

(defun appears (L e)
	(cond
		((null L) nil)
		((eq (car L) e) T)
		(T (or (appears (leftSubt L) e) (appears (rightSubt L) e)))
	))

;path(l1l2...ln,X)={nil,n=0
;					l1,l1=X
;					l1+path(leftSubt(l),X),appears(leftSubt(l),X)
;					l1+path(rightSubt(l),X),otherwise}

(defun path (L X)
	((lambda (A)
	(cond
		((null L) nil)
		((eq (car L) X) (list X))
		((appears A X) (append (list (car L)) (path A X)))
		(T (append (list (car L)) (path (rightSubt L) X)))
)) (leftSubt L)))