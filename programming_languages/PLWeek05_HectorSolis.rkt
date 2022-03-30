#lang racket


(define accuracy .0001)

(define (notAccurate y)
  (> (abs y) accuracy)
)

(define (average x y)
  (/ (+ x y) 2)
)

(define (polynomialfunc1 x)
  ; y = 5x^2 - x - 8
  (- (- (* 5 (* x x)) x) 8)
)

(define (polynomialfunc2 x)
  ; y = 4x^2 -x -2
  (- (- (* 4 (* x x)) x) 2)
)

(define (bisec function start1 start2)
  ; Function will find the zero of a polynomial function recursively with two starting
  ; values on oposite sides of an x axis.
  (define ystart1 (function start1))
  (define ystart2 (function start2))
  
  (if (or (notAccurate ystart1) (notAccurate ystart2)) 
      (if (> (abs ystart1) (abs ystart2)) (bisec function start2 (average start1 start2))
           (bisec function start1 (average start1 start2)))
      (exact->inexact (average start1 start2))
  )
)


(printf "The solution of y = 5x^2 - x - 8 is ~v ~n ~n" (bisec polynomialfunc1 1 2))


(printf "The solution of y = 4x^2 - x - 2 is ~v" (bisec polynomialfunc2 -3 0))
