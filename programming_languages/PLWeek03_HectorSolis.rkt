#lang racket


(define (function x)
  (/ 1 (* x x))
  )


(define (basel terms)
  ; Function calculates the Basel series to the nth terms through recursion. 
  (if (= terms 1) 1 (+ (function terms) (basel (- terms 1))))
  )


(exact->inexact (basel 100))
(if (= 1.634983900184893 (exact->inexact (basel 100))) "PASSED" "FAILED")