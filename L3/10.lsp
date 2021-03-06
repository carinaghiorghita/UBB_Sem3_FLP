;10. Define a function that replaces one node with another one in a n-tree represented as: root
;list_of_nodes_subtree1... list_of_nodes_subtreen)
;Eg: tree is (a (b (c)) (d) (e (f))) and node 'b' will be replace with node 'g' => tree (a (g (c)) (d) (e (f)))}

;replaceNode(L,a,b)={b,L is atom and L=a
;					L,L is atom
;					U i=1,n replaceNode(l_i)}

(defun replaceNode (L a b)
	(cond
		((and (atom L) (equal L a)) b)
		((atom L) L)
		(T (mapcar #'(lambda(L) (replaceNode L a b)) l))
))