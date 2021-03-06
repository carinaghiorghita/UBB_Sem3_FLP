;1.
;a) Write a function to return the n-th element of a list, or NIL if such an element does not exist.
;b) Write a function to check whether an atom E is a member of a list which is not necessarily linear.
;c) Write a function to determine the list of all sublists of a given list, on any level.
; A sublist is either the list itself, or any element that is a list, at any level. Example:
; (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
; ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )
;d) Write a function to transform a linear list into a set.

;(load "D:\\fac\\sem3\\plf\\L1\\1.lsp")

;1a

;nthElem(l1l2...lk,n)={nil,n>k
;						l1,n=0
;						nthElem(l2...ln,n-1)}

(defun nthElem (L n)
	(cond
		((null L) nil)
		((= n 1) (car L))
		(T (nthElem (cdr L) (- n 1)))
	)
)

;1b

;checkE(l1l2...ln,E)={nil, n=0
;						checkE(l1,E) or checkE(l2...ln,E),l1 is list
;						true,l1=e
;						checkE(l2...ln,E),otherwise}

(defun checkE (L E)
	(cond
		((null L) nil)
		((listp (car L)) (or (checkE (car L) E) (checkE (cdr L) E)))
		((= (car L) E) T)
		(T (checkE (cdr L) E))
	)
)

;1c - idk why this works, also add initial list

;getSublists(l1l2...ln)={(),n=0
;							l1+getSublists(l1)+getSublists(l2...ln), l1 is list
;							getSublists(l2...ln),otherwise}

(defun getSublists (L)
	(cond
		((null L) nil)
		((listp (car L)) (append (list (car L)) (getSublists (append (car L) (cdr L)))))
		(T (getSublists (cdr L)))
	)
)

;1d

;removeApp(l1l2...ln,e)={nil,n=0
;						removeApp(l2...ln,e),l1=e
;						l1+removeApp(l2...ln,e),otherwise}

(defun removeApp (L e)
	(cond
		((null L) nil)
		((eq (car L) e) (removeApp (cdr L) e))
		(T (cons (car L) (removeApp (cdr L) e)))
	)
)

;getSet(l1l2...ln)={nil, n=0
;					l1+getSet(removeApp(l2...ln,e)),otherwise}

(defun getSet (L)
	(cond
		((null L) nil)
		(T (cons (car L) (getSet (removeApp (cdr L) (car L)))))
	)
)