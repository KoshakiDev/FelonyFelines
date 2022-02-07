extends State

#NPC MOVE STATE

func seek_steering(desired_direction_vector: Vector2) -> Vector2:
	var desired_velocity: Vector2 = desired_direction_vector.normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func move_according_to(vector):
	var steering: Vector2 = seek_steering(vector)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering
	owner.velocity = owner.velocity.linear_interpolate(vector * owner.max_speed, .1 if vector.length() > 0 else .2)
	
	owner.velocity = owner.velocity.clamped(owner.max_speed)

func ent_dist(pos1: Vector2, pos2: Vector2):
	return (pos1 - pos2).length()


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
		state_machine.transition_to("Death")
		return
	
	var target_pos = Global.get_closest_enemy(owner.global_position)
	var total_vector
		
	# direction of motion
	var vector_to_target = target_pos - owner.global_position
	
	if ent_dist(owner.global_position, target_pos) < 50:
		total_vector = -vector_to_target
	else:
		total_vector = vector_to_target

	# moving into the direction
	move_according_to(total_vector)
	owner.movement_direction = vector_to_target
	
	
	if vector_to_target.length() < 50:
		# print("will attack")
		state_machine.transition_to("Attack")
		return
