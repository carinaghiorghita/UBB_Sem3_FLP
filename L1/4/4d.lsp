;;;;4d.Write a list to return the maximum value of the numerical atoms from a list, at superficial level.


;;;checkMax(a,b)={nil, a,b not numbers
;;;					b, a not number
;;;					a, b not number
;;;					b, b>a
;;;					a, otherwise}

(defun checkMax (A B)
	(cond
		;;if neither are numbers -> nil
		((and (not (numberp A)) (not (numberp B))) nil)
		;;if A is not a number -> B
		((not (numberp A)) B)
		;;if B is not a number -> A
		((not (numberp B)) A)
		;;check for max if both are numbers
		((> B A) B)
		(T A)
	)
)

;;;maxAtom(l1l2...ln)={l1, n=1
;;;						checkMax(l1,maxAtom(l2...ln)), otherwise}

(defun maxAtom (L)
	(cond
		;;L is not a list
		((not (listp L)) nil)
		;;L only contains a non-number atom
		((and (= (length L) 1) (not (numberp (car L)))) nil)
		;;only one element left if the list
		((null (cdr L)) (car L))
		;;find max
		(T (checkMax (car L) (maxAtom (cdr L))))
	)
)

;;;(load "D:\\fac\\sem3\\plf\\L1\\4d.lsp")

;;;Tests
;;;(maxAtom '(A 1 B 4 5 3 C D)) -> 5
;;;(maxAtom 'A) -> NIL
;;;(maxAtom '(A B)) -> NIL
;;;(maxAtom '(1)) -> 1