extends PlatformBotState

#Walk State
var direction_x
var directions = [-1, 1]

func enter(_msg := {}) -> void:
	if !player.get_is_controlled():
		player.walkTimer.start()
		directions.shuffle()
		direction_x = directions[0]
	if _msg.has("direction"):
		direction_x = _msg["direction"]
	player.animationPlayer.play("walk")

func physics_update(delta: float) -> void:
	if !player.get_is_controlled():
		not_controlled(delta)
	else:
		controlled(delta)
	
func not_controlled(delta):
	player.control_card.hide_card()
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		player.walkTimer.stop()
		return
	player.attack()
	if player.is_on_wall():
		direction_x *= -1
	if direction_x != 0:
		player.sprite.scale.x = direction_x
		player.armController.flip_arms(direction_x)
	player.velocity.x = player.walk_speed * direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	
	
func controlled(delta):
	player.control_card.show_card()
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var input_direction_x = (Input.get_action_strength("right_1") - Input.get_action_strength("left_1"))
	
	if input_direction_x != 0:
		#player.enemyDetector.scale.y = input_direction_x
		player.sprite.scale.x = input_direction_x
		player.armController.flip_arms(input_direction_x)
		#player.attack_sprite.scale.x = input_direction_x
	
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump_1"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_released("enemy_special"):
		state_machine.transition_to("Dash", {direction=input_direction_x})
