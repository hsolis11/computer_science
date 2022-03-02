#lang racket


(define (function x)
  (/ 1 (+ (* 2 x) 1))
)

(define (findSign x)
  (if (= 0 (modulo x 2)) 1 -1)
)

; Leibniz series using a subprogram for the negative sign
(define (leibniz terms)
  (if (= terms 0) 1 (+ (* (function terms) (findSign terms)) (leibniz (- terms 1))))
)

; Leibniz series using a lambda function for the negative sign
(define (lamLeibniz terms)

  (if (= terms 0) 1 (+ (* (function terms) ((lambda (x) (if (= 0 (modulo x 2)) 1 -1)) terms)) (leibniz (- terms 1))))
)

; Testing Leibniz series
(exact->inexact (leibniz 100))

(if (= 0.7878733502677476 (exact->inexact (leibniz 100))) "PASSED" "FAILED")

; Testing Leibniz series with lambda functions
(exact->inexact (lamLeibniz 100))

(if (= 0.7878733502677476 (exact->inexact (lamLeibniz 100))) "PASSED" "FAILED")
