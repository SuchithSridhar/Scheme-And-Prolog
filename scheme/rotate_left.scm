#lang scheme

(define (rotate_left n A)
  (if (null? A)
    A
    (if (= n 0)
      A 
      (rotate_left (- n 1) (append (cdr A) (list (car A))))
    )
  )
)

(display (rotate_left 1 '("o" "b" "o" "e")))
(display "\n")
(display (rotate_left 2 '("o" "b" "o" "e")))
(display "\n")
(display (rotate_left 4 '("o" "b" "o" "e")))
(display "\n")
(display (rotate_left 4 '()))
(display "\n")
