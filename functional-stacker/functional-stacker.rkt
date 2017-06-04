#lang br/quicklang

(define (read-syntax path port)
  (define args (port->lines port))
  (define handle-datums (format-datums '~a args))
  (define module-datum `(module funstacker-mod "functional-stacker.rkt"
                          (handle-args ,@handle-datums)))
  (datum->syntax #f module-datum))
(provide read-syntax)

(define-macro (funstacker-module-begin HANDLE-ARGS-EXPR)
  #'(#%module-begin
     (display (first HANDLE-ARGS-EXPR))))
(provide (rename-out [funstacker-module-begin #%module-begin]))

(define stack empty)

(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

(define (push-stack! arg)
  (set! stack (cons arg stack)))

(define (handle-args . args)
  (for/fold ([stack-acc empty])
            ([arg (filter-not void? args)])
    (cond
      [(number? arg) (cons arg stack-acc)]
      [(or (equal? * arg)
           (equal? + arg))
       (define op-result
         (arg (first stack-acc) (second stack-acc)))
       (cons op-result (drop stack-acc 2))])))
(provide handle-args)

; Note, order of operations is not supported!)
(provide + *)