;;;;L1 - Exercise 4

;;;4a.The sum of two vectors

;;; sumLists(a1a2...an,b1b2...bn)={NIL, a or b not lists OR length(a)!=length(b) OR a or b NULL
;;;									(a1+b1) U sumLists(a2...an,b2...bn), otherwise}


(defun sumLists (A B)
	(cond
		;;check if not list
		((or (atom A) (atom B)) nil)
		;;check if same length
		((not (= (length A) (length B))) nil)
		;;check if not null 
		((or (null A) (null B)) nil)
		;;construct new sum list by adding the first element of each list and calling the sum function on the rest of the list 
		(T (cons (+ (car A) (car B)) 
			(sumLists (cdr A) (cdr B))))
	)
)

;;;(load "D:\\fac\\sem3\\plf\\L1\\4a.lsp")

;;;TESTS:
;;;(sumLists '(1 2 3) '(4 5 6)) -> (5 7 9)
;;;(sumLists '(1 2 3) '(4 5)) -> NIL
;;;(sumLists '() '(4 5)) -> NIL
;;;(sumLists '3 '(4 5)) -> NIL

(defun lengthList (L)
	(cond
		((null L) 0)
		(T (+ 1 (lengthList (cdr L))))
	)
)