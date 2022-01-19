#lang racket
; Started at 11:35 pause 11:47
(define value -1)

; Write a function that calculates 30 + 2x - 3x^2
(define (function x)(+ 30 (- (* 2 x) (* 3 (* x x)))))

; Include code in the source that tests the function

; Write another function that calculates 30 + 2x - 3x^2 and prints out different
; output depending upon the result
(define (function2 x)
(define y (function x))
(printf "The value of 30 + 2x - 3x^2 where x = ~v is ~v" x y)
(cond
; if > 10 print message and result
  [(> y 10) (printf " and is greater than 10\n")]
; if < 10 print different message and result
  [(< y 10) (printf " and is less than 10\n")]
; else print different message and result
  [else (printf " and is equal to 10\n")]))
; include code that tests the function multiple times and shows each output

(function2 -10)
(function2 -1)
(function2 0)
(function2 1)
(function2 2.95)
(function2 10)