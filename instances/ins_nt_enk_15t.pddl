(define 
(problem ins_nt_enk)
(:domain dom_nt_3)
(:objects
	; tracks
	; ================================ 
	track_t_401 - track
	track_t_402 - track
	track_t_403 - track
	track_t_404 - track
	track_t_405 - track
	track_t_406 - track
	track_t_407 - track
	track_entry - track

	; trains
	; ================================ 
	train_ddz_1 - train
	train_ddz_2 - train
	train_ddz_3 - train
	train_ddz_4 - train
	train_ddz_5 - train
	train_ddz_6 - train
	train_ddz_7 - train
	train_ddz_8 - train
	train_ddz_9 - train
	train_ddz_10 - train
	train_ddz_11 - train
	train_ddz_12 - train
	train_ddz_13 - train
	train_ddz_14 - train
	train_ddz_15 - train
)

(:init

	; concurrent movement
	; ================================ 
(= (max_num_consecutive_movements) 1)
(= (num_consecutive_movements) 0)

	; track parking
	; ================================ 
	(parking_allowed track_t_401)
	(parking_allowed track_t_402)
	(parking_allowed track_t_403)
	(parking_allowed track_t_404)
	(parking_allowed track_t_405)
	(parking_allowed track_t_406)
	(parking_allowed track_t_407)

	; track lengths
	; ================================ 
	(= (track_length track_t_401) 460)
	(= (track_length track_t_402) 460)
	(= (track_length track_t_403) 460)
	(= (track_length track_t_404) 630)
	(= (track_length track_t_405) 670)
	(= (track_length track_t_406) 670)
	(= (track_length track_t_407) 570)
	(= (track_length track_entry) 2400)

	; track trains
	; ================================ 
	(= (num_trains_on_track track_t_401) 0)
	(= (num_trains_on_track track_t_402) 0)
	(= (num_trains_on_track track_t_403) 0)
	(= (num_trains_on_track track_t_404) 0)
	(= (num_trains_on_track track_t_405) 0)
	(= (num_trains_on_track track_t_406) 0)
	(= (num_trains_on_track track_t_407) 0)
	(= (num_trains_on_track track_entry) 15)

	; track spaces
	; ================================ 
	(= (stack_Aside_distance_to_end_of_track track_t_401) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_401) 0)
	(= (stack_Aside_distance_to_end_of_track track_t_402) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_402) 0)
	(= (stack_Aside_distance_to_end_of_track track_t_403) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_403) 0)
	(= (stack_Aside_distance_to_end_of_track track_t_404) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_404) 0)
	(= (stack_Aside_distance_to_end_of_track track_t_405) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_405) 0)
	(= (stack_Aside_distance_to_end_of_track track_t_406) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_406) 0)
	(= (stack_Aside_distance_to_end_of_track track_t_407) 0)
	(= (stack_Bside_distance_to_end_of_track track_t_407) 0)
	(= (stack_Aside_distance_to_end_of_track track_entry) 0)
	(= (stack_Bside_distance_to_end_of_track track_entry) 2400)

	; inter track connections
	; ================================ 
	(tracks_linked track_t_404 track_t_402)
	(tracks_linked track_t_404 track_t_403)
	(tracks_linked track_t_404 track_t_401)
	(tracks_linked track_t_405 track_t_402)
	(tracks_linked track_t_405 track_t_403)
	(tracks_linked track_t_405 track_t_401)
	(tracks_linked track_t_406 track_t_402)
	(tracks_linked track_t_406 track_t_403)
	(tracks_linked track_t_406 track_t_401)
	(tracks_linked track_t_407 track_t_402)
	(tracks_linked track_t_407 track_t_403)
	(tracks_linked track_t_407 track_t_401)
	(tracks_linked track_entry track_t_401)
	(tracks_linked track_entry track_t_402)
	(tracks_linked track_entry track_t_403)

	; train activity
	; ================================ 
	(is_active train_ddz_1)
	(is_active train_ddz_2)
	(is_active train_ddz_3)
	(is_active train_ddz_4)
	(is_active train_ddz_5)
	(is_active train_ddz_6)
	(is_active train_ddz_7)
	(is_active train_ddz_8)
	(is_active train_ddz_9)
	(is_active train_ddz_10)
	(is_active train_ddz_11)
	(is_active train_ddz_12)
	(is_active train_ddz_13)
	(is_active train_ddz_14)
	(is_active train_ddz_15)

	; train availability
	; ================================ 
	(is_available train_ddz_1)
	(is_available train_ddz_2)
	(is_available train_ddz_3)
	(is_available train_ddz_4)
	(is_available train_ddz_5)
	(is_available train_ddz_6)
	(is_available train_ddz_7)
	(is_available train_ddz_8)
	(is_available train_ddz_9)
	(is_available train_ddz_10)
	(is_available train_ddz_11)
	(is_available train_ddz_12)
	(is_available train_ddz_13)
	(is_available train_ddz_14)
	(is_available train_ddz_15)

	; train lengths
	; ================================ 
	(= (train_length train_ddz_1) 160)
	(= (train_length train_ddz_2) 160)
	(= (train_length train_ddz_3) 160)
	(= (train_length train_ddz_4) 160)
	(= (train_length train_ddz_5) 160)
	(= (train_length train_ddz_6) 160)
	(= (train_length train_ddz_7) 160)
	(= (train_length train_ddz_8) 160)
	(= (train_length train_ddz_9) 160)
	(= (train_length train_ddz_10) 160)
	(= (train_length train_ddz_11) 160)
	(= (train_length train_ddz_12) 160)
	(= (train_length train_ddz_13) 160)
	(= (train_length train_ddz_14) 160)
	(= (train_length train_ddz_15) 160)

	; train locations
	; ================================ 
	(train_at train_ddz_1 track_entry)
	(train_at train_ddz_2 track_entry)
	(train_at train_ddz_3 track_entry)
	(train_at train_ddz_4 track_entry)
	(train_at train_ddz_5 track_entry)
	(train_at train_ddz_6 track_entry)
	(train_at train_ddz_7 track_entry)
	(train_at train_ddz_8 track_entry)
	(train_at train_ddz_9 track_entry)
	(train_at train_ddz_10 track_entry)
	(train_at train_ddz_11 track_entry)
	(train_at train_ddz_12 track_entry)
	(train_at train_ddz_13 track_entry)
	(train_at train_ddz_14 track_entry)
	(train_at train_ddz_15 track_entry)

	(= (train_distance_to_end_of_track train_ddz_1) 0)
	(= (train_distance_to_end_of_track train_ddz_2) 160)
	(= (train_distance_to_end_of_track train_ddz_3) 320)
	(= (train_distance_to_end_of_track train_ddz_4) 480)
	(= (train_distance_to_end_of_track train_ddz_5) 640)
	(= (train_distance_to_end_of_track train_ddz_6) 800)
	(= (train_distance_to_end_of_track train_ddz_7) 960)
	(= (train_distance_to_end_of_track train_ddz_8) 1120)
	(= (train_distance_to_end_of_track train_ddz_9) 1280)
	(= (train_distance_to_end_of_track train_ddz_10) 1440)
	(= (train_distance_to_end_of_track train_ddz_11) 1600)
	(= (train_distance_to_end_of_track train_ddz_12) 1760)
	(= (train_distance_to_end_of_track train_ddz_13) 1920)
	(= (train_distance_to_end_of_track train_ddz_14) 2080)
	(= (train_distance_to_end_of_track train_ddz_15) 2240)

)

(:goal (and 

	; train parking
	; ================================ 
	(is_parking train_ddz_1)
	(is_parking train_ddz_2)
	(is_parking train_ddz_3)
	(is_parking train_ddz_4)
	(is_parking train_ddz_5)
	(is_parking train_ddz_6)
	(is_parking train_ddz_7)
	(is_parking train_ddz_8)
	(is_parking train_ddz_9)
	(is_parking train_ddz_10)
	(is_parking train_ddz_11)
	(is_parking train_ddz_12)
	(is_parking train_ddz_13)
	(is_parking train_ddz_14)
	(is_parking train_ddz_15)

))
)