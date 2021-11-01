extends PlatformBotState

#Air State

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse

func physics_update(delta):
	if !player.get_is_controlled():
		not_controlled(delta)
	else:
		controlled(delta)

func not_controlled(delta):
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")

func controlled(delta):
	var input_direction_x: float = (
		Input.get_action_strength("right_1")
		- Input.get_action_strength("left_1")
	)
	
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	if input_direction_x != 0:
		player.sprite.scale.x = input_direction_x
		player.armController.flip_arms(input_direction_x)
	if player.is_on_floor():
		
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
