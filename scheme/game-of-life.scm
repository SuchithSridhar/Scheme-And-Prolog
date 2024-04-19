#lang scheme

; Game of Life in Scheme
; Author: Suchith Sridhar Khajjayam
; Date: 2024 Mar 21
; Note that it might take a few seconds to run the unit tests.

; Rules of the game:
; 1. Any living square with fewer than two living neighbours die because of
;    isolation.
; 2. Any living square with more than three living neighbours dies because of
;    overcrowding.
; 3. Any living square with two or three living neighbours remains living in the
;    next generation.
; 4. Any dead square with exactly three living neighbours becomes living by
;    reproduction.

; Implementation:
; A square is represented by '(x . y)

(require "set-ops.scm")


; Get all the neighbours of a square
; square is the square to find the neighbours of.
(define (neighbours square)
  (let ((x (car square)) (y (cdr square)))
    (list 
      (cons (- x 1) (- y 1)) (cons x (- y 1)) (cons (+ x 1) (- y 1))
      (cons (- x 1) y) (cons (+ x 1) y)
      (cons (- x 1) (+ y 1)) (cons x (+ y 1)) (cons (+ x 1) (+ y 1))
    )
  )
) 

; Accepts a list of living squares and returns
; a list of squares to be considered for the next generation;
; This includes all the living-square and each of their neighbours
(define (neighbourhood living-squares)
  (if (= 0 (length living-squares))
    '()
    (union
      (neighbours (car living-squares))
      (neighbourhood (cdr living-squares))
    )
  )
)

; Accepts a list of living squares representing the current generation
; and a square which might be living or dead in the next generation.
; It returns:
;   #t if the square will be alive the next generation
;   #f otherwise.
(define (will-be-alive? living-squares square)
  (let (
      (living-neighbours-count 
        (length (intersection (neighbours square) living-squares)))
      (square-alive (member square living-squares))
    )

    (cond
      ((and square-alive (< living-neighbours-count 2)) #f)
      ((and square-alive (> living-neighbours-count 3)) #f)
      (square-alive #t)
      ((and (not square-alive) (= 3 living-neighbours-count)) #t)
      (else #f)
    )
  )
)

; Accepts a list of living squares in the current generation
; and returns the list of living squares in the next generation.
(define (next-generation living-squares)
  (filter
    (lambda (square) (will-be-alive? living-squares square))
    (neighbourhood living-squares)
  )
)

; Return the state of the game after n generations. 
; Just runs next-generation n times
(define (run-n-generations n initial-squares)
  (if (> n 0)
    (run-n-generations (- n 1) (next-generation initial-squares))
    initial-squares
  )
)


; ===================================================================
;                           Unit Tests
; ===================================================================


(require rackunit)

(check-equal? (neighbours '(0 . 0)) '((-1 . -1) (0 . -1) (1 . -1) (-1 . 0) (1 . 0) (-1 . 1) (0 . 1) (1 . 1)))
(check-equal? (neighbours '(3 . 7)) '((2 . 6) (3 . 6) (4 . 6) (2 . 7) (4 . 7) (2 . 8) (3 . 8) (4 . 8)))

(check-true (set-equals?
  (neighbourhood '((-1 . 0) (0 . 0) (1 . 0)))
  '((-1 . 1) (1 . 0) (-1 . 0) (-1 . -1) (-2 . -1) (-2 . 0) (-2 . 1) (0 . -1) (1 . -1) (2 . -1) (0 . 0) (2 . 0) (0 . 1) (1 . 1) (2 . 1))
))

(define r-pentomino '((0 . -1) (-1 . 0) (0 . 0) (0 . 1) (1 . 1)))

(check-false (will-be-alive? '((0 . 0)) '(0 . 0)))
(check-true (will-be-alive? r-pentomino '(0 . -1)))
(check-false (will-be-alive? r-pentomino '(0 . 0)))
(check-true (will-be-alive? r-pentomino '(-1 . -1)))
(check-false (will-be-alive? r-pentomino '(1 . 0)))

(check-true (set-equals? 
  (next-generation '((-1 . 0) (0 . 0) (1 . 0)))
  '((0 . -1) (0 . 0) (0 . 1))
))

(check-true (set-equals? 
  (next-generation (next-generation '((-1 . 0) (0 . 0) (1 . 0))))
  '((-1 . 0) (0 . 0) (1 . 0))
))


; Complete tests for run-n-generations

(check-true (set-equals? 
  (run-n-generations 2 '())
  '()
))

(check-true (set-equals? 
  (run-n-generations 1 '((0 . 0) (0 . 1)))
  '()
))

; horizontal-line

(check-true (set-equals? 
  (run-n-generations 1 '((-1 . 0) (0 . 0) (1 . 0)))
  '((0 . -1) (0 . 0) (0 . 1))
))

(check-true (set-equals? 
  (run-n-generations 2 '((-1 . 0) (0 . 0) (1 . 0)))
  '((-1 . 0) (0 . 0) (1 . 0))
))

(check-true (set-equals? 
  (run-n-generations 10 '((-1 . 0) (0 . 0) (1 . 0)))
  '((-1 . 0) (0 . 0) (1 . 0))
))

(check-true (set-equals? 
  (run-n-generations 11 '((-1 . 0) (0 . 0) (1 . 0)))
  '((0 . -1) (0 . 0) (0 . 1))
))

; complex case

(define inital-a '((0 . 0) (0 . -1) (0 . 1) (2 . 1)))

(check-true (set-equals? 
  (run-n-generations 0 inital-a)
  inital-a
))

(check-true (set-equals? 
  (run-n-generations 1 inital-a)
  '((-1 . 0) (0 . 0) (1 . 1))
))

(check-true (set-equals? 
  (run-n-generations 2 inital-a)
  '((0 . 0) (0 . 1))
))

(check-true (set-equals? 
  (run-n-generations 3 inital-a)
  '()
))

(define initial-b '((2 . 0) (1 . 1) (2 . 1)
                   (0 . 3) (2 . 3) (3 . 3)
                   (1 . 4)
                   (0 . 5) (1 . 5) (2 . 5))
)

(check-equal? (length (run-n-generations 16 initial-b)) 12)
(check-equal? (length (run-n-generations 101 initial-b)) 16)
(check-equal? (length (run-n-generations 124 initial-b)) 56)
(check-equal? (length (run-n-generations 127 initial-b)) 24)
