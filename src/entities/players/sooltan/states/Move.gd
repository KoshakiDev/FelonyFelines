extends State

func enter(msg := {}) -> void:
	if !owner.is_stationary:
		owner.play_animation("Run", "Movement")
	

func physics_update(delta: float) -> void:
	if owner.is_dead(): return
	
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_action_strength("right" + owner.player_id) - Input.get_action_strength("left" + owner.player_id)
	input_direction.y = Input.get_action_strength("down" + owner.player_id) - Input.get_action_strength("up" + owner.player_id)
	owner.velocity = owner.velocity.linear_interpolate(input_direction * owner.max_speed, .1 if input_direction.length() > 0 else .2)

	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		state_machine.transition_to("Idle")
