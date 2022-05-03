#lang racket


(define (revList items)
  (if (null? (cdr items))
      (first items)
      (flatten (list* (revList (rest items)) (list (first items))))
      )
  )


(define (oddRevList items)
  (define oddItems (filter odd? items))
  (revList oddItems)
  )


; (oddRevList ‘( 1 2 3 4 5 6 7 8))   returns ‘(7 5 3 1)
(oddRevList '(1 2 3 4 5 6 7 8))


; (oddRevList ‘(3 5 2 3 7 1 2 3 1 8))  returns ‘(1 3 1 7 3 5 3)
(oddRevList '(3 5 2 3 7 1 2 3 1 8))
