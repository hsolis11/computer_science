#lang racket

; Part one is a recursive function tree-insert that takes a tree and a number
; and returns the tree with the number inserted
;




(define (tree-insert number tree)
  
  (if (empty? tree)
      (append tree (list number))

      
      (if (<= number (car tree)) ; if number is less than the current node

          (if (< (length tree) 2)
              (list (car tree) (list number) '())
              (if (null? (caddr tree))
                  (list (car tree) (tree-insert number (cadr tree)) '())
                  (list (car tree) (tree-insert number (cadr tree)) (caddr tree))
                  )
              )
          
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



;(tree-insert 8 '()) ; should return '(8)
;(tree-insert 5 '(8 () ())) ; should return '(8 (5) ())
;(tree-insert 3 '(6 () (7))) ; should return '(6 (3) (7))
;(tree-insert 4 '(6 (3) (7))) ; should return '(6 (3 () (4)) (7))


; Part 2
(define (list-to-tree items tree)
  (if (< (length items) 2)
      (tree-insert (car items) tree)
      (list-to-tree (rest items) (tree-insert (first items) tree))
      )
  )



;(list-to-tree '(22 25 7 16 8 34 67 7 32 17 8 4  5 3) '())
; '(22 (7 (7 (4 (3) (5)) ()) (16 (8 (8) ()) (17))) (25 () (34 (32) (67))))



; Part 3
(define (tree-to-list sortedTree)
  ; recursive function
  ; go as far left as possible
  ; then print the value
  ; then move right
  ; going left is priority

  ; if sortedTree has cdr
  ; then tree-to-list (cadr tree)
  ; (display sortedTree)
  ; (display "\n")


  ;(if (< (length (cadr sortedTree)) 2)
  (if (or (< (length (cadr sortedTree)) 2) (< (length (caddr sortedTree)) 2))

      (if (null? (caddr sortedTree)) ; test if third value as list is null
  ;        (list (caadr sortedTree) (car sortedTree)) ; list the second digit value and the node TODO: test if caadr list is less than 2 and recurse if not
          (if (< (length (cadr sortedTree)) 2)
              (list (caadr sortedTree) (car sortedTree))
              (append (tree-to-list (cadr sortedTree)) (list (car sortedTree))))
  ;        (list (caadr sortedTree) (car sortedTree) (caaddr sortedTree)))
          
          (if (null? (cadr sortedTree)) ; else there is a third value then test if second value is null
              (if (< (length (caddr sortedTree)) 2)
                  (list (car sortedTree) (caaddr sortedTree))
                  (append (list (car sortedTree)) (tree-to-list (caddr sortedTree)))); there is no second value, list the node and the third value
              (if (< (length (cadr sortedTree)) 2)
                  (list (caadr sortedTree) (car sortedTree) (caaddr sortedTree)) ; all values are present
                  (append (tree-to-list (cadr sortedTree)) (list (car sortedTree)) (list (caaddr sortedTree))))
              ))
      (append (tree-to-list (cadr sortedTree)) (list (car sortedTree)) (tree-to-list (caddr sortedTree)))
      )
      

  ;(list (caadr sortedTree) (car sortedTree) (caaddr sortedTree)) gets the single digit
  
  )

(tree-to-list (list-to-tree '(22 25 7 16 8 34 67 7 32 17 8 4  5 3) '()))
; '(3 4 5 7 7 8 8 16 17 22 25 32 34 67)

(define test '(1 (2 () ()) (3)))
;(car test) ; returns 1
;(cdr test) ; returns '((2) (3))
;(cadr test) ; returns '(2)
;(caar test)
;(cddr test) ; returns '((3))
;(caddr test) ; returns  '(3)
;(caadr test) ; returns 2
;(caaddr test) ; returns 3
;(null? (cadr (cadr test)))
;(define test1 '(7 (4 (3) (5)) ()))
;(caaddr test1)