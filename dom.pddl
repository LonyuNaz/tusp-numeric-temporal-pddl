;Header and description

(define (domain test_n_t)

;remove requirements that are not needed
(:requirements 
    :fluents 
    :durative-actions 
    :typing
)

(:types
    pile - object
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (chosen ?pile - pile)
    (unchosen ?pile - pile)
)


(:functions ;todo: define numeric functions here
    (height ?pile - pile)
)

(:durative-action choose
    :parameters (
        ?pile - pile
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (unchosen ?pile))
    )
    :effect (and 
        (at start (not (unchosen ?pile)))
        (at end (chosen ?pile))
    )
)


;define actions here
(:durative-action stack
    :parameters (
        ?pile - pile
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (chosen ?pile))
    )
    :effect (and 
        (increase (height ?pile) 1)
    )
)

(:durative-action stack_long
    :parameters (
        ?pile - pile
    )
    :duration (= ?duration 10)
    :condition (and 
        (at start (chosen ?pile))
    )
    :effect (and 
        (increase (height ?pile) 1)
    )
)


)