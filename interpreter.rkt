#lang racket
(require test-engine/racket-tests)

#|
expr = abs expr | app expr expr | number
|#

(define-struct abs(e) #:transparent)
(define-struct app(e1 e2) #:transparent)



(define (update-index exp d ld)
  (match exp
    [(abs e)
     (abs (update-index e d (add1 ld)))]
    [(app e1 e2)
     (app (update-index e1 d ld) (update-index e2 d ld))]
    [x
     (if (< ld x)(+ x d)x)]))

(define (beta-reduce exp sub-exp depth)
  (match exp
    [(abs e)
     (abs (beta-reduce e sub-exp (add1 depth)))]
    [(app e1 e2)
     (app (beta-reduce e1 sub-exp depth) (beta-reduce e2 sub-exp depth))]
    [x
     (cond
       [(= x depth) (update-index sub-exp (sub1 depth) 0)]
       [(> x depth) (sub1 x)]
       [else x])]))

(define (interp exp)
  (match exp
    [(app e1 e2)
     (match (interp e1)
       [(abs e1-cl) (interp (beta-reduce e1-cl e2 1))])]
    [x x]))

; completely inadequate tests

(define t (abs (abs 2)))
(define f (abs (abs 1)))
(define and (abs (abs (app (app 2 1) f))))

(check-expect (interp (app (app and t) t)) t)
(check-expect (interp (app (app and f) t)) f)
(check-expect (interp (app (app and t) f)) f)
(check-expect (interp (app (app and f) f)) f)

(test)
