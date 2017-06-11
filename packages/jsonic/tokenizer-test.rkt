#lang br
(require brag/support racket/contract)
(require "./tokenizer.rkt")

(module+ test
  (require rackunit))

(module+ test
  (check-equal?
   (apply-tokenizer-maker make-tokenizer "// comment\n")
   empty)
  (check-equal?
   (apply-tokenizer-maker make-tokenizer "@$ (+ 6 7) $@")
   (list (token 'SEXP-TOK " (+ 6 7) "
                #:position 3
                #:line 1
                #:column 2
                #:span 9)))
  (check-equal?
   (apply-tokenizer-maker make-tokenizer "hi")
   (list (token 'CHAR-TOK "h"
                #:position 1
                #:line 1
                #:column 0
                #:span 1)
         (token 'CHAR-TOK "i"
                #:position 2
                #:line 1
                #:column 1
                #:span 1))))

(module+ test
  (check-true (jsonic-token? eof))
  (check-true (jsonic-token? "a string"))
  (check-true (jsonic-token? (token 'A-TOKEN-STRUCT "hi")))
  (check-false (jsonic-token? 42)))