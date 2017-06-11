#lang br/quicklang
(require json)
(require libuuid)

(define-macro (js-module-begin PARSE-TREE)
  #'(#%module-begin
     (define result-string PARSE-TREE)
     (define validated-jsexpr (string->jsexpr result-string))
     (display result-string)))
(provide (rename-out [js-module-begin #%module-begin]))

(define-macro (jsonic-char CHAR-TOK-VALUE)
  ; String Trim here to "minify" the resulting JSON produced
  ; by the source.
  #'(string-trim CHAR-TOK-VALUE))
(provide jsonic-char)

(define-macro (jsonic-program SEXP-OR-JSON-STR ...)
  #'(string-trim (string-append SEXP-OR-JSON-STR ...)))
(provide jsonic-program)

(define-macro (jsonic-sexp SEXP-STR)
  (with-pattern ([SEXP-DATUM (format-datum '~a #'SEXP-STR)])
    #'(jsexpr->string SEXP-DATUM)))
(provide jsonic-sexp)