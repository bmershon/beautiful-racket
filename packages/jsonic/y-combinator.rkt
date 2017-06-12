#lang racket

(provide Y)
(define Y
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (x) (f (lambda (g) ((x x) g)))))))