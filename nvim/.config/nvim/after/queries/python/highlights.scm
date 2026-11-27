; extends
; Python 3.15 `lazy` soft keyword (PEP 810). tree-sitter-python has no grammar
; support yet (tree-sitter/tree-sitter-python#335), so it lands in an ERROR node.
; shortcut: delete this file once the grammar knows `lazy`, then :TSUpdate python.
(module
  (ERROR
    (identifier) @keyword.import
    (#eq? @keyword.import "lazy")))
