;2. Return the list of nodes on the k-th level of a tree of type (1).

;traverse left subtree

;travLeft(l1l2...ln,v,m)={nil, n=0
;							nil, v=m+1
;							l1+l2+travLeft(l3...ln,v+1,m+l2),otherwise}


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

;kthLvl(l1l2...ln,k,lvl)={[],n=0
;							l1,lvl=k
;							kthLvl(leftSubt(l1...ln),k,lvl+1)+kthLvl(rightSubt(l1l2...ln),k,lvl+1),otherwise}

(defun kthLvl (L k lvl)
	(cond
		((null L) nil)
		((eq lvl k) (list (car L)))
		(T (append (kthLvl (leftSubt L) k (+ 1 lvl)) (kthLvl (rightSubt L) k (+ 1 lvl))))
))