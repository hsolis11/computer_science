#lang racket

(require racket/draw) ; graphics library
(require colors)


; dimensions of the canvas
(define imageWidth 512)
(define imageHeight 288)

(define myTarget (make-bitmap imageWidth imageHeight)) ; A bitmap
(define dc (new bitmap-dc% [bitmap myTarget])) ; a drawing context

; add the background image
(send dc set-brush (make-color 0 0 0) 'solid) ; fill color fill_mode

(send dc draw-rectangle
      0 0 ; Top-left at (40, 40) pixels down from the top-left
      512 288)

(define (drawHexagon)
  (send dc set-pen "red" 1 'solid) 
  (define myPolygon (new dc-path%))
  (send myPolygon move-to -2.5 -5)
  (send myPolygon line-to -5 0)
  (send myPolygon line-to -2.5 5)
  (send myPolygon line-to 2.5 5)
  (send myPolygon line-to 5 0)
  (send myPolygon line-to 2.5 -5)
  (send myPolygon close)
  
  myPolygon
  )

; Create the hexagon polygon
(define myPolygon (drawHexagon))
; Draw the hexagon polygon
(send dc draw-path myPolygon)


(send myPolygon scale 3 3)
(send myPolygon rotate 0.2)
(send myPolygon translate 20 80)
(send dc draw-path myPolygon)

(send myPolygon translate 80 0)
(send myPolygon scale 1.5 1.5)
(send dc draw-path myPolygon)


(define (functionOne thePolygon rotationValue colorHue)
  (define myHsv (hsv colorHue 1.0 1.0))
  (send thePolygon rotate rotationValue) 
  (send dc set-pen (hsv->color myHsv) 1 'solid)
  (send dc set-brush (hsv->color myHsv) 'solid)
  (send dc draw-path myPolygon)
  )

(define (circleAround)
  (for ([i 91])
    (define rotationValue (degrees->radians (/ 360 90)))
    (define colorValue (* i 0.01))
    (functionOne myPolygon rotationValue colorValue)
    )
  )

(circleAround)

(send myTarget save-file "myPic.png" 'png)

myTarget
