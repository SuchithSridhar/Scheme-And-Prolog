#lang scheme

(define (fibonacci n)
    (if (<= n 2)
      1
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))
    )
)

(define (displayFibonacciTill n)
  (if (<= n 0)
    0
    (begin
      (displayFibonacciTill (- n 1))
      (display (string-append (number->string n) " " (number->string (fibonacci n)) "\n"))
    )
  )
)

(displayFibonacciTill 40)
