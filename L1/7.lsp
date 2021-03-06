;7.
;a) Write a function to eliminate the n-th element of a linear list.
;b) Write a function to determine the successor of a number represented digit by digit as a list, without
;transforming the representation of the number from list to number. 
; Example: (1 9 3 5 9 9) --> (1 9 3 6 0 0)
;c) Write a function to return the set of all the atoms of a list.
; Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)
;d) Write a function to test whether a linear list is a set.

;7a

;elim(l1l2...lk,n)={l2...lk,n=0
;					l1+elim(l2...lk,n-1),otherwise}

(defun elim (L n)
	(cond
		((eq n 1) (cdr L))
		(T (cons (car L) (elim (cdr L) (- n 1))))
))

;7b

;functiile pt reverse din 3.lsp

(defun appendL (L e)
	(cond
		((null L) (list e))
		(T (cons (car L) (appendL (cdr L) e)))
	)
)

(defun reverseL (L)
	(cond
		((null L) nil)
		((listp (car L)) (append (reverseL (cdr L)) (reverseL (car L))))
		(T (appendL (reverseL (cdr L)) (car L)))
	)
)

;(1 9 3 5 9 9) -> (9 9 5 3 9 1)
;we'll start with carry=1 in order to find the successor (+1)

;succ(l1l2...ln,c)={c,n=0
;					(l1+c)%10 + succ(l2...ln,(l1+c)/10),otherwise}

(defun succ (L c)
	(cond
		((and (null L) (eq c 1)) (list c))
		((null L) nil)
		;(and (null (cdr L)) (list (mod (+ c (car L)) 10)))
		((< (+ (car L) c) 10) (append (list (mod (+ (car L) c) 10)) (succ (cdr L) 0)))
		(T (append (list (mod (+ (car L) c) 10)) (succ (cdr L) 1)))
))

;wrapper(l1l2...ln)=reverseL(succ(reverseL(l1l2...ln),1))

(defun wrapper (L)
		(reverseL (succ (reverseL L) 1))
)

;7c

;linearize(l1l2...ln)={nil,n=0
;						linearize(l1)+linearize(l2...ln),l1 is list
;						l1+linearize(l2...ln),otherwise}

(defun linearize (L)
	(cond
		((null L) nil)
		((listp (car L)) (append (linearize (car L)) (linearize (cdr L))))
		(T (append (list (car L)) (linearize (cdr L))))
))

;removeOcc(l1l2...ln,e)={nil, n=0
;						removeOcc(l2...ln,e),l1=e
;						l1+removeOcc(l2...ln,e),ohterwise}

(defun removeOcc (L e)
	(cond
		((null L) nil)
		((eq e (car L)) (removeOcc (cdr L) e))
		(T (cons (car L) (removeOcc (cdr L) e)))
))

;getSet - 1.lsp

(defun getSet (L)
	(cond
		((null L) nil)
		(T (cons (car L) (getSet (removeOcc (cdr L) (car L)))))
	)
)

;wrapper(l1l2...ln)=getSet(linearize(l1l2...ln))

(defun wrapperSet (L)
	(getSet (linearize L))	
)

;7d

;contains(l1l2...ln,e)={nil,n=0
;						true,l1=e
;						contains(l2...ln,e),otherwise}

(defun contains (L e)
	(cond
		((null L) nil)
		((eq (car L) e) T)
		(T (contains (cdr L) e))
))

;isSet(l1l2...ln)={true,n=0
;					nil, contains(l2...ln,l1)
;					isSet(l2...ln),otherwise}

(defun isSet (L)
	(cond
		((null L) T)
		((contains (cdr L) (car L)) nil)
		(T (isSet (cdr L)))
))