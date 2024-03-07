#lang racket
(require "interpreter.rkt")
(require test-engine/racket-tests)

; completely inadequate tests

(define t (abs (abs 2)))
(define f (abs (abs 1)))
(define and (abs (abs (app (app 2 1) f))))

(check-expect (interp (app (app and t) t)) t)
(check-expect (interp (app (app and f) t)) f)
(check-expect (interp (app (app and t) f)) f)
(check-expect (interp (app (app and f) f)) f)

(test)
