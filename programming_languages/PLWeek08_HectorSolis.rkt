#lang racket

; Part one is a recursive function tree-insert that takes a tree and a number
; and returns the tree with the number inserted
;




(define (tree-insert number tree)
  
  (if (empty? tree)
      (append tree (list number))

      
      (if (< number (car tree)) ; if number is less than the current node

          ;(if (null? (caddr tree))
          (if (< (length tree) 2)
              (list (car tree) (list number) '())
              (if (null? (caddr tree))
                  (list (car tree) (tree-insert number (cadr tree)) '())
                  (list (car tree) (tree-insert number (cadr tree)) (caddr tree))
                  )
              )
          
          ;(if (null? (cadr tree))
          (if (< (length tree) 2)
              (list (car tree) '() (list number))
              (if (null? (cadr tree))
                  (list (car tree) '() (tree-insert number (caddr tree)))
                  (list (car tree) (cadr tree) (tree-insert number (caddr tree)))
                  )
              )
       )
      )
  )



(tree-insert 8 '()) ; should return '(8)
(tree-insert 5 '(8 () ())) ; should return '(8 (5) ())
(tree-insert 3 '(6 () (7))) ; should return '(6 (3) (7))
(tree-insert 4 '(6 (3) (7))) ; should return '(6 (3 () (4)) (7))
