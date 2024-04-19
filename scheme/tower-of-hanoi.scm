#lang scheme

; Tower of Hanoi

(define (move_disk from to)
  (display (string-append "Move from peg " from " to peg " to "\n"))
)

(define (tower_of_hanoi n startPeg endPeg middlePeg)
  (if (= n 1)
    (move_disk startPeg endPeg)
    (begin
      (tower_of_hanoi (- n 1) startPeg middlePeg endPeg)
      (move_disk startPeg endPeg)
      (tower_of_hanoi (- n 1) middlePeg endPeg startPeg)
    )
  )
)

(tower_of_hanoi 1 "A" "C" "B")
(display "\n")
(tower_of_hanoi 2 "A" "C" "B")
(display "\n")
(tower_of_hanoi 3 "A" "C" "B")
