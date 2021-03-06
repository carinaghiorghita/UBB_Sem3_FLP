;;;;4c.Write a function that, with a list given as parameter, inverts only continuous
;;;;sequences of atoms. Example:
;;;;(a b c (d (e f) g h i)) ==> (c b a (d (f e) i h g))


;;;reverseList(l1l2...ln)={nil, l is null
;;;							reverseList(l2...ln) U l1, otherwise}

(defun reverseList (L)
	(cond
		((null l) nil)
		;;append the list formed by the first element to the end of the rest of the list
		(T (append (reverseList (cdr L)) (list (car L))))
	)
)


;;;invertList(l1l2...ln, aux)={reverseList(aux), l is null
;;;								reverseList(aux) U (invertList(l1,nil) U invertList(l2...ln,nil)),l1 is a list
;;;								invertList(l2...ln,aux U l1),otherwise}

(defun invertList (L aux)
	(cond
		((null L) (reverseList aux))
		;;if L is not a list we return nil
		((atom L) nil)
		;;L1 is a list -> we construct a list formed of the inverted L1 list and the inverted rest of the list, 
		;;to which we append the reverse of the aux list (the list we obtaind so far on a superficial level)
		((listp (car L)) (append (reverseList aux) (cons (invertList (car L) nil) (invertList (cdr L) nil))))
		;;L1 is an atom -> we invert the rest of the list and we append L1 to the aux list
		(T (invertList (cdr L) (append aux (list(car L)))))
	)
)

;;;(load "D:\\fac\\sem3\\plf\\L1\\4c.lsp")

;;; !!! always give NIL as aux parameter !!!

;;;Tests
;;;(invertList '(A B C (D (E F) G H I)) nil) -> (C B A (D (F E) I H G))
;;;(invertList '() nil) -> NIL
;;;(invertList 'A nil) -> NIL