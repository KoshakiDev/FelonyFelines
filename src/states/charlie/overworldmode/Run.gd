extends PlayerCharlieStateOverworldMode



func enter(msg := {}) -> void:
	player.animationPlayer.play("run")

func physics_update(delta: float) -> void:
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_action_strength("right_2") - Input.get_action_strength("left_2")
	input_direction.y = Input.get_action_strength("down_2") - Input.get_action_strength("jump_2")
	player.velocity = player.velocity.linear_interpolate(input_direction * player.run_speed, .1 if input_direction.length() > 0 else .2)
	
	if input_direction.x != 0:
		player.enemyDetector.scale.y =  input_direction.x
		player.sprite.scale.x =  input_direction.x
		player.attack_sprite.scale.x =  input_direction.x
	
	player.velocity = player.move_and_slide(player.velocity)
	if Input.is_action_just_pressed("action_2"):
		if player.enemyDetector.get_overlapping_bodies().size() > 0:
			var target
			for i in player.enemyDetector.get_overlapping_bodies():
				target = i
				break
			if Chip.is_with_charlie == true or target.get_is_controlled() == true:
				state_machine.transition_to("MoveChip")
	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		state_machine.transition_to("Idle")
		
		
	
