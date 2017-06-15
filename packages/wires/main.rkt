#lang br/quicklang

(module+ reader
  (provide read-syntax))

(define (read-syntax path port)
  (define wire-datums
    (for/list ([wire-str (in-lines port)])
      (format-datum '(wire ~a) wire-str)))
  (strip-bindings
   #`(module wires-mod wires/main
       #,@wire-datums)))

(provide #%module-begin)

(define-macro-cases wire
  [(wire ARG -> WIRE) #'(define/display (WIRE)
                          (val ARG))]
  [(wire OP ARG -> WIRE) #'(define/display (WIRE)
                             (OP (val ARG)))]
  [(wire ARG1 OP ARG2 -> WIRE) #'(define/display (WIRE)
                                   (OP (val ARG1) (val ARG2)))]
  [else #'(void)])
(provide wire)

(define-macro (define/display (ID) BODY)
  #'(begin
      (define (ID) BODY)
      (module+ main
        (displayln (format "~a: ~a" 'ID (ID))))))

(define val
  (let ([val-cache (make-hash)])
    (lambda (num-or-wire)
      (if (number? num-or-wire)
          num-or-wire
          ; num-or-wire may be a thunk provided to the hash table.
          (hash-ref! val-cache num-or-wire num-or-wire)))))

(define (mod-16bit x) (modulo x 65536))
(define-macro (define-16bit ID PROC-ID)
  ; Perform the appropriate wire operation and then
  ; ensure the value is only 16 bytes. This
  ; appropriately simulates overflow in the wire problem.
  #'(define ID (compose1 mod-16bit PROC-ID)))

(define-16bit AND bitwise-and)
(define-16bit OR bitwise-ior)
(define-16bit NOT bitwise-not)
(define-16bit LSHIFT arithmetic-shift)
(define (RSHIFT x y) (LSHIFT x (- y)))
(provide AND OR NOT LSHIFT RSHIFT)