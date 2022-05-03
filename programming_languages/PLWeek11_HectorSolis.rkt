#lang racket

(require racket/draw) ; graphics library
(require colors)


; dimensions of the canvas
(define imageWidth 2048)
(define imageHeight 1152)

;dimensions of the world
(define worldWidth 4096);1024
(define worldHeight 2304);576

(define myTarget (make-bitmap imageWidth imageHeight)) ; A bitmap
(define dc (new bitmap-dc% [bitmap myTarget])) ; a drawing context

(send dc set-brush (make-color 0 0 0) 'solid) ; fill color fill_mode
(send dc draw-rectangle 0 0 imageWidth imageHeight)


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

(define (colorIt myPolygon x)
    (define colorValue (* (random 0 90) (/ .999 90)))
    (define myHsv (hsv colorValue 1.0 1.0)) 
    (send dc set-pen (hsv->color myHsv) .01 'solid)
    ;(send dc set-brush "Black" 'transparent)
    (drawToScreen myPolygon)
  )


(define (main)

  (for ([i (in-range 1000 1 -1)])
    (send myPolygon translate (* .001 i) (* .001 i))

    (for ([j (in-range 100 1 -1)])
      (define iFactor (* i 2))
      (define scaleXValue (* (expt j 7) 0.000000000001))
      (define scaleYValue (* (expt j 7) 0.000000000001))
      (define randomTranslateX (random (- iFactor) iFactor))
      (define randomTranslateY (random (- iFactor) iFactor))
      (define rotationValue (degrees->radians (/ 360 180)))
      
      (send myPolygon rotate rotationValue)
      
      (send myPolygon scale scaleXValue scaleYValue)
      (send myPolygon translate randomTranslateX randomTranslateY)
      
      (colorIt myPolygon i)
      
      (send myPolygon translate (- randomTranslateX) (- randomTranslateY))
      (send myPolygon scale (/ 1 scaleXValue) (/ 1 scaleYValue))
      
      )
    )
  )


(main)

(send myTarget save-file "myPic.png" 'png)


myTarget
