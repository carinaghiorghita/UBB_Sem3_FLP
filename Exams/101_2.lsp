;Given a nonlinear list containing both numerical and non-numerical atoms, write a LISP program
;that calculates the total number of non-numerical atoms at the superficial level of the sublists (including
;the original list) having the first numerical atom (at any level) an even number. For example, for the
;list (A B 12 (5 D (A F (10 B) D (5 F) 1)) C 9) the result will be 7.
;A B C A F D B
;(defun checkFirstNum (L)
;	(cond
;		((null L) nil)
;		((and (numberp (car L)) (equal 0 (mod (car L) 2))) T)
;		((numberp (car L)) nil)
;		((atom (car L)) (checkFirstNum (cdr L)))
;		(T (or (checkFirstNum (car L)) (checkFirstNum (cdr L))))
;))

(defun linearize (L)
	(cond
		((null L) nil)
		((listp (car L)) (append (linearize (car L)) (linearize (cdr L))))
		(T (append (list (car L)) (linearize (cdr L))))
))

(defun checkFirstNum (L)
	(cond
		((null L) nil)
		((and (numberp (car L)) (equal 0 (mod (car L) 2))) T)
		((numberp (car L)) nil)
		(T (checkFirstNum (cdr L)))
	))

(defun check (L)
	(checkFirstNum (linearize L)))

(defun countAt (L)
	(cond
		((null L) 0)
		((and (atom (car L)) (not (numberp (car L))) (check L)) (+ 1 (countAt (cdr L))))
		((atom (car L)) (countAt (cdr L)))
		(T (+ (countAt (car L)) (countAt (cdr L))))
))

;we should also get the atoms after the number somehow
;------------------
#|
(defun nrAtomsOnLvl (L lvl K)
	(cond
		((null L) 0)
		((and (atom (car L)) (not (numberp (car L))) (equal K lvl)) (+ 1 (nrAtomsOnLvl (cdr L) lvl K)))
		((atom (car L)) (nrAtomsOnLvl (cdr L) lvl K))
		(T (+ (nrAtomsOnLvl (car L) (+ 1 lvl) K) (nrAtomsOnLvl (cdr L) lvl K)))
))

(defun getOnLvl (L lvl K)
	(cond
		((null L) nil)
		((and (atom L) (equal K lvl)) L)
		((listp (car L))(getOnLvl (cdr L) lvl K))
		(T (getOnLvl (cdr L) lvl K))
))

(defun countAtoms (L K)
	(cond
		((eq K 0) 0)
		((check L) (+ (nrAtomsOnLvl L 1 K) (countAtoms L (- K 1))))
		(T (countAtoms L (- K 1)))
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

(defun sol (L)
	(countAtoms L (getNrLevels L 1)))
|#
;----------------------
;get nr of nonnum atoms on each sublist: 1-3, 2-1, 3-3, 4.1-1, 4.2-1

(defun nrNonnumAtoms (L)
	(cond
		((null L) 0)
		((and (atom (car L)) (not (numberp (car L)))) (+ 1 (nrNonnumAtoms (cdr L))))
		(T (nrNonnumAtoms (cdr L)))
))
;ok=1 means counted on current sublist
(defun countAtoms (L ok)
	(cond
		((null L) 0)
		((and (equal ok 0) (check L)) (+ (nrNonnumAtoms L) (countAtoms (cdr L) 1)))
		((listp (car L)) (+ (countAtoms (car L) 0) (countAtoms (cdr L) ok)))
		(T (countAtoms (cdr L) ok))
))