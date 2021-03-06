;;;;4b.Write a function to get from a given list the list of all atoms, 
;;;;on any level, but on the same order. Example:
;;;;(((A B) C) (D E)) ==> (A B C D E)

;;;atomsList(l1l2...ln)={NIL, l=null
;;;						atomsList(l1) U atomsList(l2...ln),l1=list
;;;						l1 U atomsList(l2...ln),otherwise}


(defun atomsList (L)
	(cond
		;;check if list is null
		((null L) nil)
		;;check if L is an atom
		((atom L) L)
		;;L1 is a list -> we append the rest of the list's atoms to those of L1
		((listp (car L))(append (atomsList (car L)) (atomsList (cdr L))))
		;;L1 is an atom -> we append the rest of the atoms to L1
		(T (cons (car L) (atomsList(cdr L))))
	)
)



;;;(load "D:\\fac\\sem3\\plf\\L1\\4b.lsp")


;;;Tests
;;;(atomsList '()) -> NIL
;;;(atomsList '(((A B) C) (D E))) -> (A B C D E)
;;;(atomsList 'A) -> A