extends State

# THIS IS NPC MOVE STATE, NOT PLAYERS

func seek_steering(desired_direction_vector: Vector2) -> Vector2:
	var desired_velocity: Vector2 = desired_direction_vector.normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func move_according_to(vector):
	var steering: Vector2 = seek_steering(vector)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering
	owner.velocity = owner.velocity.clamped(owner.max_speed)


func enter(msg := {}) -> void:
	if msg.has("Accel"):
		owner.play_animation("Accel", "Movement")
		yield(owner.movement_player, "animation_finished")
	if owner.fast_run:
		owner.play_animation("Run_2", "Movement")
	else:
		owner.play_animation("Run_1", "Movement")	


func exit() -> void:
	owner.play_animation("Decel_1", "Movement")

func physics_update(delta: float) -> void:
	if owner.is_dead():
		print("dead")
		state_machine.transition_to("Death")
		return

	var target_pos = Global.get_farthest_player(owner.global_position)
	var total_vector
	
	# direction of motion
	var vector_to_target = target_pos - owner.global_position
	
	total_vector = vector_to_target
	
	# moving into the direction
	move_according_to(total_vector)
	owner.movement_direction = vector_to_target

	if owner.bodies_in_engage_area > 0:
		state_machine.transition_to("Attack")
		return
