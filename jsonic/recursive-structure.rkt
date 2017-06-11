#lang jsonic
// A recursive definition for a random tree structure,
// written in jsonic, which extends JSON to support
// arbitray Racket symbolic expressions (S-expressions).
{
 "name": "root",
 "id": @$ (uuid-generate) $@,
 "type": @$ (list-ref '(5 20) (random 0 2)) $@,
 "children":
 @$
 ; The following expression creates a random list of nodes.
 (map
  ; No define allowed in an expression context, so the
  ; applicative-order Y combinator is used to provide
  ; a mechanism for recursion.
  ((lambda (f)
      ((lambda (x) (x x))
       (lambda (x) (f (lambda (g) ((x x) g))))))
    ; "Almost" a recursive definition for a node. The following relies on
    ; Y-Combinator to create a fixpoint for this function.
    (lambda (node)
      ; A recursive definition for a node, assuming node produces
      ; a node (this means node is the fixpoint for "almost-node" lambda).
      (lambda (depth)
        (hash 'name depth
              'id (uuid-generate)
              'type (list-ref '(5 20) (random 0 2))
              ; Check the current depth, only allowing further recursion if
              ; we have not exceeded the depth limit.
              'children (if (zero? depth)
                            '() ; No children, otherwise...
                            (map (lambda (n) (node (- depth 1)))
                                 ; Random number of children in [0, max-width]
                                 (range 0 (random 0 3))))))))
   ; The top level of the tree has 3 children with the following max-depths.
   '(3 8 4))
 $@
}
