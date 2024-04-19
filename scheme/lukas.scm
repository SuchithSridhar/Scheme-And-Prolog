#lang scheme


(define (lukas n)
  (cond ((= n 0) 2)
        ((= n 1) 1)
        (#t (let next-iteration ((m 2) (lnum1 (lukas 0)) (lnum2 (lukas 1)))
          (let ((lm (+ lnum1 lnum2)))
            (if (= n m)
              lm
              (next-iteration (+ m 1) lnum2 lm)
            )
          )
        ))
  )
)

(display (lukas 30))
