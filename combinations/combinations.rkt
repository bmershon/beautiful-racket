#lang racket

; Prints all numbers that could be represented by strings of the form:
; 1001?01?11 where the ? characters indicate unknown binary digits.
(define combinations
  (lambda (x)
    (print "" x)))

;; Print all combinations, using prefix and suffix
;; arguments to process the string with unknown digits.
(define print
  (lambda (prefix suffix)
    (cond
      ((zero? (string-length suffix)) (displayln prefix))
      ((equal? (substring suffix 0 1) "?")
       (begin
         (print (string-append prefix "0") (substring suffix 1))
         (print (string-append prefix "1") (substring suffix 1))))
       (else (print (string-append prefix (substring suffix 0 1)) (substring suffix 1))))))

; Returns the number represented by the binary number
; in the given string of 1's and 0's.
(define binary->decimal
  (lambda (b)
    (cond
      ((zero? (string-length b)) 0)
      ((equal? (substring b 0 1) "1")
       (+ (/ (expt 2 (string-length b)) 2) (binary->decimal (substring b 1))))
      (else (binary->decimal (substring b 1))))))

; Test binary to decimal.
(binary->decimal "100101") ;; 37
(binary->decimal "101") ;; 5
                
; Test printing combinations
(combinations "10?01?001?11")
;; 100010001011
;; 100010001111
;; 100011001011
;; 100011001111
;; 101010001011
;; 101010001111
;; 101011001011
;; 101011001111