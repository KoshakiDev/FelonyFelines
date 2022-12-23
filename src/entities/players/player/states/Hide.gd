extends State

func enter(msg := {}) -> void:
	owner.play_animation("Hide", "Movement")
	#owner.is_hidden = true

func exit():
	pass
	#owner.is_hidden = false

func physics_update(_delta: float) -> void:
	if owner.health_manager.is_dead(): state_machine.transition_to("Death")

	if owner.interacting:
		state_machine.transition_to("Interacting")
	

	if !owner.is_in_shadow:
		state_machine.transition_to("Idle")
	
	if Input.is_action_pressed("left" + owner.player_id) or Input.is_action_pressed("right" + owner.player_id) or Input.is_action_just_pressed("up" + owner.player_id) or Input.is_action_pressed("down" + owner.player_id):
		state_machine.transition_to("Move")
