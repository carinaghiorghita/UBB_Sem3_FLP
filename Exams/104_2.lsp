;Given a nonlinear list containing both numerical and non-numerical atoms, write a LISP program
;that returns the list from which non-numerical atoms are eliminated from 3 to 3 (counting from the left
;to the right, considering all elements regardless of level). The resulted list will keep the structure of
;the initial list. For example, for the list (A B 12 (5 D (A F (10 B) D (5 F) 1)) C 9 (F 4 (D) 9 (F (H 7) K) (P 4)) X) 
;the result will be the list (A B 12 (5 (A F (10) D (5 F) 1)) 9 (F 4 (D) 9 ((H 7) K) (4)) X).
;(A B 12 (5 D (A F (10 B) D (5 F) 1)) C 9 (F 4 (D) 9 (F (H 7) K) (P 4)) X)
(defun lengthL (L)
	(cond 
		((null L) 0)
		((listp (car L)) (+ (lengthL (car L)) (lengthL (cdr L))))
		((and (atom (car L)) (not (numberp (car L)))) (+ 1 (lengthL (cdr L))))
		(T (lengthL (cdr L)))
))

(defun elimAtoms (L pos)
	(cond
		((null L) nil)
		((and (atom (car L)) (not (numberp (car L))) (equal 0 (mod pos 3))) (elimAtoms (cdr L) (+ 1 pos)))
		((and (atom (car L)) (not (numberp (car L)))) (cons (car L) (elimAtoms (cdr L) (+ 1 pos))))
		((atom (car L)) (cons (car L) (elimAtoms (cdr L) pos)))
		(T (cons (elimAtoms (car L) pos) (elimAtoms (cdr L) (+ pos (lengthL (car L))))))
))

(defun getAtomsOnLevel (L lvl K)
	(cond
		((and (atom L) (not (numberp L)) (equal K lvl)) (list L))
		((atom L) nil)
		(T (mapcan #'(lambda (A) (getAtomsOnLevel A (+ 1 lvl) K)) L))
))

(defun getMax (a b)
	(cond
		((> a b) a)
		(T b)
))

(defun getNrLevels (L lvl)
	(cond
		((null L) lvl)
		((listp (car L)) (getMax (getNrLevels (car L) (+ 1 lvl)) (getNrLevels (cdr L) lvl)))
		(T (getNrLevels (cdr L) lvl))
))

(defun getList (L k)
	(cond
		((> k (getNrLevels L 1)) nil)
		(T (cons (getAtomsOnLevel L 0 k) (getList L (+ 1 k))))
))
;--------------
;71_B
;Given a nonlinear list that contains numerical and non-numerical atoms, write a Lisp program that
;builds a list that has a level for each level of the initial list and on each level has three elements: the
;number of numerical atoms on that level from the initial list, a sublist that contains these information
;for the rest of the levels and the numbers of nonnumerical atoms from that level in the initial list. For
;example, for the list (A B (4 A 3) 11 (5 (A (B) C 10) (1(2(3(4)5)6)7) X Y Z)) the result will be (1 (3 (3
;(2 (2 (1 0) 0) 1) 2) 4) 2).
(defun getNrLevels (L lvl)
	(cond
		((null L) lvl)
		((listp (car L)) (getMax (getNrLevels (car L) (+ 1 lvl)) (getNrLevels (cdr L) lvl)))
		(T (getNrLevels (cdr L) lvl))
))


(defun getNrAtomsOnLevel (L lvl K)
	(cond
		((and (atom L) (not (numberp L)) (equal K lvl)) 1)
		((atom L) 0)
		(T (apply #'+ (mapcar #'(lambda (A) (getNrAtomsOnLevel A (+ 1 lvl) K)) L)))
))

(defun getNrNumOnLevel(L lvl K)
(cond
		((and (atom L) (numberp L) (equal K lvl)) 1)
		((atom L) 0)
		(T (apply #'+ (mapcar #'(lambda (A) (getNrNumOnLevel A (+ 1 lvl) K)) L)))
)
	)
;start with k=1; somehow can't get rid of the nil in the middle
(defun constrList (L K)
	(cond
		((> K (getNrLevels L 1)) nil)
		(T (append (list (getNrNumOnLevel L 0 K)) (append (list (constrList L (+ 1 K))) (list (getNrAtomsOnLevel L 0 K)))))
))