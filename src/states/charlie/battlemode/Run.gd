extends State

func enter(msg := {}) -> void:
	owner.animationPlayer.play("run")

func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	var input_direction_x = (Input.get_action_strength("right_2") - Input.get_action_strength("left_2"))
	
	if input_direction_x != 0:
		owner.enemyDetector.scale.y = input_direction_x
		owner.sprite.scale.x = input_direction_x
		owner.attack_sprite.scale.x = input_direction_x
	#owner.velocity.x += owner.accel * input_direction_x * delta
	owner.velocity.x = owner.run_speed * input_direction_x
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	if Input.is_action_just_pressed("action_2"):
		if owner.enemyDetector.is_colliding() == true:
			if Chip.is_with_charlie == true or owner.enemyDetector.get_collider().get_is_controlled() == true:
				state_machine.transition_to("MoveChip")
	elif Input.is_action_just_pressed("jump_2"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
