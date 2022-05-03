#lang racket

(require racket/draw) ; graphics library
(require colors)


; dimensions of the canvas
(define imageWidth 512)
(define imageHeight 288)

;dimensions of the world
(define worldWidth 1024)
(define worldHeight 576)

(define myTarget (make-bitmap imageWidth imageHeight)) ; A bitmap
(define dc (new bitmap-dc% [bitmap myTarget])) ; a drawing context

; add the background image
(send dc set-brush (make-color 0 0 0) 'solid) ; fill color fill_mode
(send dc draw-rectangle 0 0 512 288)


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


(define (drawToScreen myPolygon)
  (define xScale (/ imageWidth worldWidth))
  (define yScale (/ imageHeight worldHeight))
  (define xTrans (- (* (- (/ worldWidth 2)) xScale)))
  (define yTrans (- (* (- (/ worldHeight 2)) yScale)))
  
  (send myPolygon scale xScale yScale)
  (send myPolygon translate xTrans yTrans)
  (send dc draw-path myPolygon)
  (send myPolygon translate (- xTrans) (- yTrans))
  (send myPolygon scale (/ 1 xScale) (/ 1 yScale))
  )


(define myPolygon (drawHexagon))

(drawToScreen myPolygon)

(send myPolygon translate 60 60)
(drawToScreen myPolygon)

(send myPolygon scale 2.5 2.5)
(drawToScreen myPolygon)

(send myPolygon translate 20 20)


(define (circleAround myPolygon)
  (for ([i 91])
    (define rotationValue (degrees->radians (/ 360 90)))
    (define colorValue (* i (/ .999 90)))
    (define myHsv (hsv colorValue 1.0 1.0))
    
    (send myPolygon rotate rotationValue) 
    (send dc set-pen (hsv->color myHsv) 1 'solid)
    (send dc set-brush (hsv->color myHsv) 'solid)
    (drawToScreen myPolygon)
    )
  )


(circleAround myPolygon)


(send myTarget save-file "myPic.png" 'png)


myTarget
