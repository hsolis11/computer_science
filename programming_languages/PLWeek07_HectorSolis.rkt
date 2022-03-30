#lang racket

; Write a function that takes a list of numbers as input and returns a list of the numbers
; in ascending order.
; Use the quicksort algorithm
; Use ( 20 13 74 5 12 9 22 95 22 6 101 72 3 53 33 21 96) as input
; To do that, calculate the average value of a sublist before diving it.

; (quicksort'( 20 13 74 5 12 9 22 95 22 6 101 72 3 53 33 21 96))
; returns ‘(3 5 6 9 12 13 20 21 22 22 33 53 72 74 95 96 101)

; Do not use sort, quicksort, set!, or mean.

(define myList (list 20 13 74 5 12 9 22 95 22 6 101 72 3 53 33 21 96))
(define solvedList (list 3 5 6 9 12 13 20 21 22 22 33 53 72 74 95 96 101))

(define (functionSum x)
  ; function takes a list of numbers as input
  ; returns the sum of the list
  (if (empty? x) 0
      (+ (first x) (functionSum (rest x))))
  )

(define (functionMean x)
  ; function takes a list  of numbers as input
  ; returns the average of the list
  (exact->inexact (/ (functionSum x) (length x)))
  )


(define (functionSort x)
  ; function takes a list of numbers as input
  ; returns a list of the numbers in ascending order.

  ; get the mean
  (define theMean (functionMean x))

  ; create two new lists
  ; create list more than average
  (define moreThan (filter (lambda (y) (> y theMean)) x))

  ; create list less than average
  (define lessThan (filter (lambda (y) (<= y theMean)) x))
  
  ; append the two lists sorted in reference to mean
  
  (if (and (> (length x) 1) (not (= theMean (car x))))
  ;(define newList (append (functionSort lessThan) (functionSort moreThan)))
  (append (functionSort lessThan) (functionSort moreThan))
  (append lessThan moreThan)
  )
  )

(display "Unordered list: ")
(functionSort myList)

(display "\nSolved list: ")
(display solvedList)

(display "\n\nUnordered list is equal to solved list: ")
(equal? (functionSort myList) solvedList)