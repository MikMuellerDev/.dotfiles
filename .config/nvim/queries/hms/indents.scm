[
  (arguments)
  (infix_expr)
  (parameters)
  (paren_expr)
  (return_stmt)
  (break_stmt)
  (block)
  (call_expr)
] @indent

; (arguments (call_expr) @indent)
; (infix_expr (call_expr) @indent)
; (expression_statement (call_expr) @indent)
(assign_expr
  right: (_) @_right
  (#not-has-type? @_right fn_expr)
) @indent
(let_stmt
  value: (_) @_value
  (#not-has-type? @_value call_expr fn_expr)
) @indent

[")" "}"] @indent_end

[
  ")"
  "}"
] @branch
(block "{" @branch)

(comment) @ignore

(ERROR) @auto
