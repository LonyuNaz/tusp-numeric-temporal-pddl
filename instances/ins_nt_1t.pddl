(define 
(problem ins_nt_1t)
(:domain dom_nt_1)
(:objects
	; operators
	; ================================ 
	Andy - driver

	; tracks
	; ================================ 
	track_401 - track
	track_402 - track
	track_403 - track
	track_404 - track
	track_405 - track
	track_406 - track
	track_407 - track
	track_entry - track

	; trains
	; ================================ 
	train_ddz_1 - train
	train_ddz_2 - train
)
(:init

	; metric
	; operators
	; ================================ 
	(idle Andy)

	; track lengths
	; ================================ 
	(parking_allowed track_401)
	(= (track_length track_401) 460)
	(= (Astack_length track_401) 0)
	(= (Bstack_length track_401) 0)
	(= (Astack_queue_length track_401) 0)
	(= (Bstack_queue_length track_401) 0)
	
	(parking_allowed track_402)
	(= (track_length track_402) 460)
	(= (Astack_length track_402) 0)
	(= (Bstack_length track_402) 0)
	(= (Astack_queue_length track_402) 0)
	(= (Bstack_queue_length track_402) 0)
	
	(parking_allowed track_403)
	(= (track_length track_403) 460)
	(= (Astack_length track_403) 0)
	(= (Bstack_length track_403) 0)
	(= (Astack_queue_length track_403) 0)
	(= (Bstack_queue_length track_403) 0)
	
	(parking_allowed track_404)
	(= (track_length track_404) 630)
	(= (Astack_length track_404) 0)
	(= (Bstack_length track_404) 0)
	(= (Astack_queue_length track_404) 0)
	(= (Bstack_queue_length track_404) 0)

	(parking_allowed track_405)
	(= (track_length track_405) 670)
	(= (Astack_length track_405) 0)
	(= (Bstack_length track_405) 0)
	(= (Astack_queue_length track_405) 0)
	(= (Bstack_queue_length track_405) 0)
	
	(parking_allowed track_406)
	(= (track_length track_406) 670)
	(= (Astack_length track_406) 0)
	(= (Bstack_length track_406) 0)
	(= (Astack_queue_length track_406) 0)
	(= (Bstack_queue_length track_406) 0)
	
	(parking_allowed track_407)
	(= (track_length track_407) 570)
	(= (Astack_length track_407) 0)
	(= (Bstack_length track_407) 0)
	(= (Astack_queue_length track_407) 0)
	(= (Bstack_queue_length track_407) 0)
	
	; NOT (parking_allowed track_entry)
	(= (track_length track_entry) 320)
	(= (Astack_length track_entry) 2)
	(= (Bstack_length track_entry) 0)
	(= (Astack_queue_length track_entry) 320)
	(= (Bstack_queue_length track_entry) 0)

	; inter track connections
	; ================================ 
	(linked track_405 track_401)
	(linked track_406 track_401)
	(linked track_407 track_401)
	(linked track_404 track_401)
	(linked track_405 track_402)
	(linked track_406 track_402)
	(linked track_407 track_402)
	(linked track_404 track_402)
	(linked track_405 track_403)
	(linked track_406 track_403)
	(linked track_407 track_403)
	(linked track_404 track_403)
	(linked track_entry track_401)
	(linked track_entry track_402)
	(linked track_entry track_403)

	; train activity
	; ================================ 
	(active train_ddz_1)
	(available train_ddz_1)
	(unoperated train_ddz_1)
    (direction_Aside train_ddz_1)
    (= (train_length train_ddz_1) 160)
	
	(active train_ddz_2)
    (available train_ddz_2)
    (unoperated train_ddz_2)
    (direction_Aside train_ddz_2)
    (= (train_length train_ddz_2) 160)


	; train locations
	; ================================ 
	(at train_ddz_1 track_entry)
	(= (queue_number train_ddz_1) 1)
	
	(at train_ddz_2 track_entry)
	(= (queue_number train_ddz_2) 2)
)
(:goal (and 
	; train parking
	; ================================ 
	(has_parked train_ddz_1)
	(has_parked train_ddz_2)
))
(:metric minimize (cost))
)