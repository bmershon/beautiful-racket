#lang jsonic
[
  null,
  @$ (exact->inexact (/ 3 5)) $@,
  true,
  ["array", "of", "strings"],
  {
    "key-1": null,
    "key-2": false,
    "key-3": {"subkey": 21}
  },
  @$ (= 2 (+ 1 1)) $@
]