;An n-ary tree is represented in Lisp as ( node subtree1 subtree2 ...). Write a Lisp function to
;verify whether a node x occurs on an even level of the tree. The root level is assumed zero. A
;MAP function shall be used.
;Example for the tree (a (b (g)) (c (d (e)) (f))) a) x=g => T b) x=h => NIL

(defun checkNodeEvenLvl (L X lvl)
	(cond 
		((and (atom L) (equal L X) (equal 0 (mod lvl 2))) (list T))
		((atom L) nil)
		(T (mapcan #'(lambda (A) (checkNodeEvenLvl A X (+ 1 lvl))) L))
))

(defun wrapperCheck (L X)
	(car (checkNodeEvenLvl L X -1)))

(defun sumDigits (X)
	(cond
		((> 1 (/ X 10)) (mod X 10))
		(T (+ (mod X 10) (sumDigits (/ (- X (mod X 10)) 10))))
))

(defun g(l)
	(cond
		((null l) nil)
		(t (
				(lambda (v)

					(cons (car v) (cadr v))
				)
			(f l)
			)
		)
	)
)

;get elements on positions div with K in reverse order 
(defun getElemsFromK (L K lvl)
	(cond
		((null L) nil)
		((and (atom (car L)) (equal 0 (mod lvl K))) (append (getElemsFromK (cdr L) K (+ 1 lvl)) (list (car L))))
		(T (getElemsFromK (cdr L) K (+ 1 lvl)))
))

(defun removeE (L E)
	(cond
		((and (atom L) (equal E L)) nil)
		((atom L) (list L))
		(T (list (apply #'append (mapcar #'(lambda (A) (removeE A E)) L))))
))

(defun wrapperRemove (L E)
	(car (removeE L E)))