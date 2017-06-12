#lang jsonic
// Brooks Mershon, 2017
//
// A recursive definition for a random tree structure,
// written in jsonic, which extends JSON to support
// arbitray Racket symbolic expressions (S-expressions).
{
 // This is the root node.
 "name": "root",
 "id": @$ (uuid-generate) $@,
 "type": @$ (list-ref '(5 20) (random 0 2)) $@,
 "children":@$
 ; The following S-expression creates a random list of nodes.
 (map
  ; No define allowed in an expression context, so the
  ; applicative-order Y combinator is used to provide
  ; a mechanism for recursion.
  (Y
    ; "Almost" a recursive definition for a node. The following relies on
    ; Y-Combinator to create a fixpoint for this function.
    (lambda (node)
      ; A recursive definition for a node.
      (lambda (depth)
        ; A node is returned with a random subtree if depth > 0.
        (hash 'name (string-join (lorem-generate (random 1 3)))
              'definition (string-join (lorem-generate (random 1 5)))
              'id (uuid-generate)
              'type (list-ref '(5 20) (random 0 2))
              'children (if (zero? depth)
                            '() ; No children, otherwise...
                            (map (lambda (n) (node (- depth 1)))
                                 ; Random number of children in [0, max-width]
                                 (range 0 (random 0 3))))))))
   ; The top level of the tree has between 5 and 15 children, each with a maximum depth
   ; of their subtree limited to a number between 5 and 15.
   (map (lambda (n) (random 1 5)) (range 1 (random 2 6))))
 $@
}