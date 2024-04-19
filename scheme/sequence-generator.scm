#lang scheme

; Author: Suchith Sridhar Khajjayam
; Date: 2024 Mar 11

; Calculate the next term in the sequence given the
; current terms and the coefficients.
; next = term[0] * coefficients[0] + term[1] * coefficients[1] ...
; Assumes length of terms and coeffs are the same. 
(define (calculate-next-term terms coeffs)
  (if (equal? terms '())
    0
    (+ 
      (* (car terms) (car coeffs))
      (calculate-next-term (cdr terms) (cdr coeffs))
    )
  )
)

; Get a function to generate terms of a linear recurrence relation
; defined on a set of initial terms and coefficients. 
; Assumptions:
;     - initial-terms and coefficients match in length
;     - the sequence starts from 0. i.e., 
;       the last element of initial-terms is the 0th term.
(define (sequence-generator initial-terms coefficients)
  (lambda (n) 
    (let ((len_terms (length initial-terms)))
      (if (< n len_terms)
        (list-ref initial-terms n)
        (let function ((index len_terms) (terms initial-terms))
          (let ((next-term (calculate-next-term terms coefficients)))
            (if (= n index)
              next-term
              (function (+ index 1) (append (cdr terms) (list next-term)))
            )
          )
        )
      )
    )
  )
)


; A function to get the nth term in the padovan series 
; padovan(0) = 0; padovan(3) = 2; padovan(10) = 12
(define padovan (sequence-generator '(1 1 1) '(1 1 0)))


(require rackunit)

; Fibonacci Sequence Test
(define fibonacci_test (sequence-generator '(0 1) '(1 1)))
(check-equal? (fibonacci_test 0) 0)
(check-equal? (fibonacci_test 1) 1)
(check-equal? (fibonacci_test 5) 5)
(check-equal? (fibonacci_test 10) 55)

; Padovan Sequence Test
(define padovan_test (sequence-generator '(1 1 1) '(1 1 0)))
(check-equal? (padovan_test 0) 1)
(check-equal? (padovan_test 1) 1)
(check-equal? (padovan_test 2) 1)
(check-equal? (padovan_test 3) 2)
(check-equal? (padovan_test 4) 2)
(check-equal? (padovan_test 5) 3)
(check-equal? (padovan_test 6) 4)
(check-equal? (padovan_test 10) 12)

(define pad1000 95947899754891883718198635265406591795729388343961013326205746660648433358757497113284765865744376976832226705511219598880)

(check-equal? (padovan_test 25) 816)
(check-equal? (padovan_test 40) 55405)
(check-equal? (padovan_test 100) 1177482265857)
(check-equal? (padovan_test 1000) pad1000)

; Lucas Numbers Test
(define lucas_test (sequence-generator '(2 1) '(1 1)))
(check-equal? (lucas_test 0) 2)
(check-equal? (lucas_test 1) 1)
(check-equal? (lucas_test 2) 3)
(check-equal? (lucas_test 3) 4)
(check-equal? (lucas_test 4) 7)
(check-equal? (lucas_test 4) 7)
(check-equal? (lucas_test 39) 141422324)
