extends PlayerCaretakerState


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var input_direction_x = (Input.get_action_strength("right_1") - Input.get_action_strength("left_1"))
	
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump_1"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("shift"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_released("off"):
		state_machine.transition_to("Off")
