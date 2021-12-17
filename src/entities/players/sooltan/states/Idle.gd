extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Movement")

func physics_update(_delta: float) -> void:
	if owner.is_dead(): return
	
	if Input.is_action_pressed("left" + owner.player_id) or Input.is_action_pressed("right" + owner.player_id) or Input.is_action_just_pressed("up" + owner.player_id) or Input.is_action_pressed("down" + owner.player_id):
		state_machine.transition_to("Move")
	else:
		state_machine.transition_to("Idle")
	
