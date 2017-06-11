#lang br/quicklang
(require brag/support racket/contract)

(provide jsonic-token?)
(define (jsonic-token? x)
  (or (eof-object? x) (string? x) (token-struct? x)))

(define (make-tokenizer port)
  (port-count-lines! port)
  (define (next-token)
    (define jsonic-lexer
      (lexer
       [(eof) eof]
       [(from/to "//" "\n") (next-token)]
       [(from/to "@$" "$@")
        (token 'SEXP-TOK (trim-ends "@$" lexeme "$@")
               #:position (+ (pos lexeme-start) 2)
               #:line (line lexeme-start)
               #:column (+ (col lexeme-start) 2)
               #:span (- (pos lexeme-end)
                         (pos lexeme-start) 4))]
       [any-char (token 'CHAR-TOK lexeme
                        #:position (pos lexeme-start)
                        #:line (line lexeme-start)
                        #:column (col lexeme-start)
                        #:span (- (pos lexeme-end)
                                  (pos lexeme-start)))]))
    (jsonic-lexer port))
  next-token)
(provide
 (contract-out
  [make-tokenizer (input-port? . -> . (-> jsonic-token?))]))