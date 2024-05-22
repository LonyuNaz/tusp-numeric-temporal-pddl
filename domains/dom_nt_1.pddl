;Header and description

(define (domain dom_nt_1)

;remove requirements that are not needed
(:requirements 
    :fluents 
    :durative-actions
    :typing 
    :equality
    :conditional-effects
)

(:types 
    train - object
    track - object
    driver - object
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    ; driver
    (idle ?driver - driver)

    ; driver & train
    (driving_train ?driver - driver ?train - train)

    ; train
    (active ?train - train)
    (operated ?train - train)
    (unoperated ?train - train)
    (available ?train - train)
    (direction_Aside ?train - train)
    (direction_Bside ?train - train)
    (has_parked ?train - train)

    ; train and track
    (at ?train - train ?track - track)    

    ; track
    (parking_allowed ?track - track)
    (linked ?trackLeft - track ?trackRight - track)
)


(:functions ;todo: define numeric functions here
    ; train
    (train_length ?train - train)
    (train_distance_to_end ?train - train)

    ; track
    (track_length ?track - track)
    (stack_Aside_distance_to_end ?track - track)
    (stack_Bside_distance_to_end ?track - track)
    (num_trains_on_track ?track - track)
)


(:durative-action enter_train
    :parameters (
        ?driver - driver
        ?train - train
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (idle ?driver)
        ))
        (over all (and 
            (active ?train)
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (operated ?train)
            (not (unoperated ?train))

            (not (idle ?driver))
            (driving_train ?driver ?train)
        ))
    )
)

(:durative-action exit_train
    :parameters (
        ?driver - driver
        ?train - train
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (driving_train ?driver ?train)
        ))
        (over all (and 
            (active ?train)
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (operated ?train))
            (unoperated ?train)

            (idle ?driver)
            (not (driving_train ?driver ?train))
        ))
    )
)

(:durative-action turn_to_Aside
    :parameters (
        ?train - train
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (direction_Bside ?train)
        ))
        (over all (and 
            (active ?train)
            (operated ?train)
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (direction_Bside ?train))
            (direction_Aside ?train)
        ))
    )
)

(:durative-action turn_to_Bside
    :parameters (
        ?train - train
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (direction_Aside ?train)
        ))
        (over all (and 
            (active ?train)
            (operated ?train)
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (direction_Aside ?train))
            (direction_Bside ?train)
        ))
    )
)

(:durative-action park_at
    :parameters (
        ?train - train
        ?track - track
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)    
        ))
        (over all (and 
            (active ?train)
            (unoperated ?train)
            (at ?train ?track)
            (parking_allowed ?track)       
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)
            (has_parked ?train)
        ))
    )
)



(:durative-action move_Aside_onto_empty_track
    :parameters (
        ?train - train
        ?trackLeft - track
        ?trackRight - track
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (at ?train ?trackLeft)

            ; we must be at the front of the Astack queue
            (= (train_distance_to_end ?train) (stack_Aside_distance_to_end ?trackLeft))

            ; the other track must be empty (otherwise move aside onto occupied track)
            (= (num_trains_on_track ?trackRight) 0)
            ; there must be enough space for us to move into
            (>=
                (track_length ?trackRight)
                (train_length ?train)
            )
        ))
        (over all (and 
            (active ?train)
            (operated ?train)
            (direction_Aside ?train)
            (linked ?trackLeft ?trackRight)   
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (at ?train ?trackLeft))
            (at ?train ?trackRight)

            (decrease (stack_Aside_distance_to_end ?trackLeft) (train_length ?train))
            (decrease (num_trains_on_track ?trackLeft) 1)

            (assign (stack_Aside_distance_to_end ?trackRight) 0)
            (assign (stack_Bside_distance_to_end ?trackRight) (train_length ?train))
            (assign (train_distance_to_end ?train) 0)
            (increase (num_trains_on_track ?trackRight) 1)
        ))
    )
)

(:durative-action move_Aside_onto_occupied_track
    :parameters (
        ?train - train
        ?trackLeft - track
        ?trackRight - track
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (at ?train ?trackLeft)

            ; we must be at the front of the Astack queue
            (= (train_distance_to_end ?train) (stack_Aside_distance_to_end ?trackLeft))

            ; the other track must be occupied (otherwise move aside onto empty track)
            (> (num_trains_on_track ?trackRight) 0)
            
            ; there must be enough space for us to move into
            (>=
                (-
                    (track_length ?trackRight)
                    (stack_Bside_distance_to_end ?trackRight)
                )
                (train_length ?train)
            )
        ))
        (over all (and 
            (active ?train)
            (operated ?train)
            (direction_Aside ?train)
            (linked ?trackLeft ?trackRight)   
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (at ?train ?trackLeft))
            (at ?train ?trackRight)

            (decrease (stack_Aside_distance_to_end ?trackLeft) (train_length ?train))
            (decrease (num_trains_on_track ?trackLeft) 1)

            (assign (train_distance_to_end ?train) (stack_Bside_distance_to_end ?trackRight))
            (increase (stack_Bside_distance_to_end ?trackRight) (train_length ?train))
            (increase (num_trains_on_track ?trackRight) 1)
        ))
    )
)

(:durative-action move_Bside_onto_empty_track
    :parameters (
        ?train - train
        ?trackRight - track
        ?trackLeft - track
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (at ?train ?trackRight)

            ; we must be at the front of the queue when looking at the Bside
            (= 
                (+
                    (train_distance_to_end ?train) 
                    (train_length ?train)
                )
                (stack_Bside_distance_to_end ?trackRight)                
            )

            ; the other track must be empty (otherwise move aside onto occupied track)
            (= (num_trains_on_track ?trackLeft) 0)

            ; there must be enough space for us to move into
            (>=
                (track_length ?trackLeft)
                (train_length ?train)
            )
        ))
        (over all (and 
            (active ?train)
            (operated ?train)
            (direction_Bside ?train)
            (linked ?trackLeft ?trackRight)   
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (at ?train ?trackRight))
            (at ?train ?trackLeft)

            (decrease (stack_Bside_distance_to_end ?trackRight) (train_length ?train))
            (decrease (num_trains_on_track ?trackRight) 1)

            (assign (stack_Aside_distance_to_end ?trackLeft) (- (track_length ?trackLeft) (train_length ?train)))
            (assign (stack_Bside_distance_to_end ?trackLeft) (track_length ?trackLeft))
            (assign (train_distance_to_end ?train) (stack_Aside_distance_to_end ?trackLeft))
            (increase (num_trains_on_track ?trackLeft) 1)
            
        ))
    )
)

(:durative-action move_Bside_onto_occupied_track
    :parameters (
        ?train - train
        ?trackRight - track
        ?trackLeft - track
    )
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (available ?train)
            (at ?train ?trackRight)

            ; we must be at the front of the queue when looking at the Bside
            (= 
                (+
                    (train_distance_to_end ?train) 
                    (train_length ?train)
                )
                (stack_Bside_distance_to_end ?trackRight)                
            )

            ; the other track must be empty (otherwise move aside onto occupied track)
            (> (num_trains_on_track ?trackLeft) 0)

            ; there must be enough space for us to move into
            (>=
                (stack_Aside_distance_to_end ?trackLeft)
                (train_length ?train)
            )
        ))
        (over all (and 
            (active ?train)
            (operated ?train)
            (direction_Bside ?train)
            (linked ?trackLeft ?trackRight)   
        ))
    )
    :effect (and 
        (at start (and 
            (not (available ?train))
        ))
        (at end (and 
            (available ?train)

            (not (at ?train ?trackRight))
            (at ?train ?trackLeft)

            (decrease (stack_Bside_distance_to_end ?trackRight) (train_length ?train))
            (decrease (num_trains_on_track ?trackRight) 1)

            (decrease (stack_Aside_distance_to_end ?trackLeft) (train_length ?train))
            (assign (train_distance_to_end ?train) (stack_Aside_distance_to_end ?trackLeft))
            (increase (num_trains_on_track ?trackLeft) 1)
            
        ))
    )
)




)