#lang scheme

(define (factorial n)
  (let fact ((m 0) (p 1))
    (if (= n m)
      p
      (fact (+ m 1) (* p (+ m 1)))
    )
  )
)

(display (factorial 5))
