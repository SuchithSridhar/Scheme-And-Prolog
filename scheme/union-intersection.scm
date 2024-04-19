#lang scheme

; Author: Suchith Sridhar Khajjayam
; Date: 2024 Mar 04 
; Problem Statement: Build functions
; 'union' and 'intersection' using lists
; to represents sets.

; --- Check if a list contains duplicate values ---
(define (has-duplicate? a)
  (if (equal? a '())
    #f
    (if (member (car a) (cdr a))
      #t
      (has-duplicate? (cdr a))
    )
  )
)

; --- Remove all the duplicates from a list ---
(define (remove-duplicates a)
  (if (equal? a '())
    a
    (if (member (car a) (cdr a))
      (remove-duplicates (cdr a))
      (cons (car a) (remove-duplicates (cdr a)))
    )
  )
)

; --- Check if a is a subset of b ---
; like real sets - duplicates are ignored
(define (subset? a b)
  (if (or (has-duplicate? a) (has-duplicate? b))
    ; If either set contains duplicates, call with duplicates removed.
    (subset? (remove-duplicates a) (remove-duplicates b))
    (if (equal? a '())
      #t
      (if (member (car a) b)
        (subset? (cdr a) b)
        #f
      )
    )
  )
)

; --- Check if two sets a and b are equal ---
; like real sets - duplicates are ignored
(define (set-equals? a b)
  (and (subset? a b) (subset? b a))
)

; --- Check if two sets a and b are equal ---
; Check if two sets are strictly equal
; this would require a and b to not have duplicates
; and for the elements in a to be present in b
; and the element in b present in a
(define (set-strict-equals? a b)
  (if (or (has-duplicate? a) (has-duplicate? b))
    #f
    (set-equals? a b)
  )
)

; --- Union two sets a and b ---
; The function merges the two sets a and b
; represented as lists. It removes any existing
; duplicates in the combined list.
(define (union a b)
  (if (has-duplicate? a)
    (union (remove-duplicates a) b)
    (if (equal? b '())
      a
      (let ((x (union a (cdr b))))
        (if (member (car b) x)
          x
          (cons (car b) x)
        )
      )
    )
  )
)

; --- Intersection between two sets a and b
; The functions finds the intersection between two
; sets a and b represented as lists. It removes any existing
; duplicates in the combined list.
(define (intersection a b)
  (if (or (equal? a '()) (equal? b '()))
    '()
    (if (or (member (car a) (cdr a)) (not (member (car a) b)))
      (intersection (cdr a) b)
      (cons (car a) (intersection (cdr a) b))
    )
  )
)

(require rackunit)

; ---- has-duplicate? ------

(check-false (has-duplicate? '()))
(check-false (has-duplicate? '(1)))
(check-false (has-duplicate? '(1 2)))
(check-true (has-duplicate? '(1 1)))
(check-true (has-duplicate? '(1 1 2)))
(check-true (has-duplicate? '(1 2 1)))
(check-true (has-duplicate? '(2 1 1)))
(check-false (has-duplicate? '(2 1 3)))

; ---- subset? ----

(check-true (subset? '() '()))

(check-true (subset? '(1) '(1)))
(check-false (subset? '(1) '(2)))
(check-true (subset? '() '(2)))

(check-true (subset? '(1 1) '(1 1)))
(check-true (subset? '(1) '(1 1)))
(check-true (subset? '(1 1) '(1)))

(check-true (subset? '(1 2) '(1 2)))
(check-true (subset? '(2 1) '(1 2)))

(check-true (subset? '(2) '(1 2)))
(check-true (subset? '(1) '(1 2)))

(check-true (subset? '(1 2) '(1 2 3)))
(check-true (subset? '(1 2) '(1 3 2)))
(check-true (subset? '(1 2) '(3 1 2)))

(check-true (subset? '(2 1 2 1 3 3 2) '(1 2 3)))

; ---- set-equals? -----

(check-true (set-equals? '() '()))

(check-true (set-equals? '(1) '(1)))
(check-false (set-equals? '(1) '(2)))
(check-false (set-equals? '() '(2)))

(check-true (set-equals? '(1 1) '(1 1)))
(check-true (set-equals? '(1) '(1 1)))
(check-true (set-equals? '(1 1) '(1)))

(check-true (set-equals? '(1 2) '(1 2)))
(check-true (set-equals? '(2 1) '(1 2)))

(check-false (set-equals? '(2) '(1 2)))
(check-false (set-equals? '(1) '(1 2)))

(check-false (set-equals? '(1 2) '(1 2 3)))
(check-false (set-equals? '(1 2) '(1 3 2)))
(check-false (set-equals? '(1 2) '(3 1 2)))

(check-true (set-equals? '(2 1 2 1 3 3 2) '(1 2 3)))

(check-true (set-equals? '(1 2) '(1 2)))
(check-true (set-equals? '(2 1) '(1 2)))

(check-false (set-equals? '(2) '(1 2)))
(check-false (set-equals? '(1) '(1 2)))

(check-false (set-equals? '(1 2) '(2)))
(check-false (set-equals? '(1 2) '(1)))

(check-false (set-equals? '(1 2 3) '(1 2))) 
(check-false (set-equals? '(1 3 2) '(1 2))) 
(check-false (set-equals? '(3 1 2) '(1 2))) 

(check-false (set-equals? '(1 2) '(1 2 3)))
(check-false (set-equals? '(1 2) '(1 3 2)))
(check-false (set-equals? '(1 2) '(3 1 2)))

(check-true (set-equals? '(2 1 2 1 3 3 2) '(1 2 3)))
(check-true (set-equals? '(1 2 3) '(2 1 2 1 3 3 2)))

; ---- set-strict-equals? -----

(check-true (set-strict-equals? '() '()))

(check-true (set-strict-equals? '(1) '(1)))
(check-false (set-strict-equals? '(1) '(2)))
(check-false (set-strict-equals? '() '(2)))

(check-false (set-strict-equals? '(1 1) '(1 1)))
(check-false (set-strict-equals? '(1) '(1 1)))
(check-false (set-strict-equals? '(1 1) '(1)))

(check-true (set-strict-equals? '(1 2) '(1 2)))
(check-true (set-strict-equals? '(2 1) '(1 2)))

(check-false (set-strict-equals? '(2) '(1 2)))
(check-false (set-strict-equals? '(1) '(1 2)))

(check-false (set-strict-equals? '(1 2) '(1 2 3)))
(check-false (set-strict-equals? '(1 2) '(1 3 2)))
(check-false (set-strict-equals? '(1 2) '(3 1 2)))

; ---- remove-duplicates ----

(check-true (set-strict-equals? (remove-duplicates '()) '()))
(check-true (set-strict-equals? (remove-duplicates '(1)) '(1)))
(check-true (set-strict-equals? (remove-duplicates '(1 2)) '(1 2)))
(check-true (set-strict-equals? (remove-duplicates '(1 1)) '(1)))
(check-true (set-strict-equals? (remove-duplicates '(1 1 2)) '(1 2)))
(check-true (set-strict-equals? (remove-duplicates '(1 2 1)) '(1 2)))
(check-true (set-strict-equals? (remove-duplicates '(2 1 1)) '(1 2)))
(check-true (set-strict-equals? (remove-duplicates '(2 1 3)) '(1 2 3)))
(check-true (set-strict-equals? (remove-duplicates '(2 1 2 1 3 3 2)) '(1 2 3)))

; ---- union ----

(check-true (set-strict-equals? (union '() '()) '()))

(check-true (set-strict-equals? (union '() '(2)) '(2)))
(check-true (set-strict-equals? (union '(2) '()) '(2)))

(check-true (set-strict-equals? (union '(2) '(2)) '(2)))
(check-true (set-strict-equals? (union '(2) '(1)) '(2 1)))
(check-true (set-strict-equals? (union '(1) '(2)) '(2 1)))

(check-true (set-strict-equals? (union '(1 2) '(2)) '(1 2)))
(check-true (set-strict-equals? (union '(2) '(1 2)) '(1 2)))

(check-true (set-strict-equals? (union '(1 2 3) '(1)) '(1 2 3)))
(check-true (set-strict-equals? (union '(1 2 3) '(2)) '(1 2 3)))
(check-true (set-strict-equals? (union '(1 2 3) '(3)) '(1 2 3)))

(check-true (set-strict-equals? (union '(1) '(1 2 3)) '(1 2 3)))
(check-true (set-strict-equals? (union '(2) '(1 2 3)) '(1 2 3)))
(check-true (set-strict-equals? (union '(3) '(1 2 3)) '(1 2 3)))

(check-true (set-strict-equals? (union '(1 2) '(2 3)) '(1 2 3)))
(check-true (set-strict-equals? (union '(2 3) '(1 2)) '(1 2 3)))

(check-true (set-strict-equals? (union '(1 2 3 4 5 6) '(2 4 6 7 1)) '(1 2 3 4 5 6 7)))

; ---- Union with duplicates ----
; These test try to test union with duplicate values in either list
; union should just return a list contains the union with each value only
; listed once. That is, it should remove duplicates.

(check-true (set-strict-equals? (union '(1 1 1) '(1 2 3)) '(1 2 3)))
(check-true (set-strict-equals? (union '(1 2 3) '(1 1 1)) '(1 2 3)))
(check-true (set-strict-equals? (union '(2 1 2 1 3 3 2) '(1 2 3)) '(1 2 3)))


; ---- Intersection ----

(check-true (set-strict-equals? (intersection '() '()) '()))

(check-true (set-strict-equals? (intersection '() '(2)) '()))
(check-true (set-strict-equals? (intersection '(2) '()) '()))

(check-true (set-strict-equals? (intersection '(2) '(2)) '(2)))
(check-true (set-strict-equals? (intersection '(2) '(1)) '()))
(check-true (set-strict-equals? (intersection '(1) '(2)) '()))

(check-true (set-strict-equals? (intersection '(1 2) '(2)) '(2)))
(check-true (set-strict-equals? (intersection '(2) '(1 2)) '(2)))

(check-true (set-strict-equals? (intersection '(1 2 3) '(1)) '(1)))
(check-true (set-strict-equals? (intersection '(1 2 3) '(2)) '(2)))
(check-true (set-strict-equals? (intersection '(1 2 3) '(3)) '(3)))

(check-true (set-strict-equals? (intersection '(1) '(1 2 3)) '(1)))
(check-true (set-strict-equals? (intersection '(2) '(1 2 3)) '(2)))
(check-true (set-strict-equals? (intersection '(3) '(1 2 3)) '(3)))

(check-true (set-strict-equals? (intersection '(1 2) '(2 3)) '(2)))
(check-true (set-strict-equals? (intersection '(2 3) '(1 2)) '(2)))

(check-true (set-strict-equals? (intersection '(1 2 3 4 5 6) '(2 4 6 7 1)) '(1 2 4 6)))
(check-true (set-strict-equals? (intersection '(1 1 1) '(1 2 3)) '(1)))
(check-true (set-strict-equals? (intersection '(1 2 3) '(1 1 1)) '(1)))
(check-true (set-strict-equals? (intersection '(2 1 2 1 3 3 2) '(1 2 3)) '(1 2 3)))
