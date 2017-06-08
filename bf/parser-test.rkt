#lang br
(require "parser.rkt")

; A test string encoding a brainfuck program that should
; print the "@" character to the standard output.
(define atsign "++++-+++-++-++[>++++-+++-++-++<-]>.")

; A Syntax Object is created by parsing the brainfuck
; program using the grammar specified in "parser.rkt"
; Since that file uses brag, a convenience application
; which produces a parser from a given grammar specified
; BNF notation, a parse-to-datum procedure is available.
; The datum is the raw text associated with the program.
(parse-to-datum atsign)

; A syntax object is produced.
(parse atsign)