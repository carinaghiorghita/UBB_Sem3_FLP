;An n-ary tree is represented in Lisp as ( node subtree1 subtree2 ...). Write a function to replace
;all nodes on odd levels with a given value e. The root level is assumed zero. A MAP function
;shall be used.
;Example for the tree (a (b (g)) (c (d (e)) (f))) and e=h => (a (h (g)) (h (d (h)) (h)))

;replace(L,e,lvl)={e, if L is atom and lvl%2=1
;					L, L is atom
;					U i=1,n replace(L_i,e,lvl+1),otherwise}

(defun replaceL (L e lvl)
	(cond
		((and (atom L) (equal 1 (mod lvl 2))) e)
		((atom L) L)
		(T (mapcar #'(lambda (A) (replaceL A e (+ 1 lvl))) L))
))

(defun wrapperReplace (L e)
	(replaceL L e -1))

;(load "D:\\fac\\sem3\\plf\\exams\\100_4.lsp")