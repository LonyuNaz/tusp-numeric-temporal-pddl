(define (problem test_n_t) (:domain test_n_t)
(:objects 
    nazars_pile - pile
)

(:init
    (unchosen nazars_pile)
)

(:goal (and
    (= (height nazars_pile) 10)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
