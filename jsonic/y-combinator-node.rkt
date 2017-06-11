#lang br
(((lambda (f)
    ((lambda (x) (x x))
     (lambda (x) (f (lambda (g) ((x x) g))))))
      (lambda (self) (lambda (n)
        (hash 'name n
              'children (map (lambda (n) (self n)) (range 0 (random 0 3))))
              ))) 3)