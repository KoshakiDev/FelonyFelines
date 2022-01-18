extends State

func seek_steering(desired_direction_vector: Vector2) -> Vector2:
	var desired_velocity: Vector2 = desired_direction_vector.normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func move_according_to(vector):
	var steering: Vector2 = seek_steering(vector)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering

	owner.velocity = owner.velocity.clamped(owner.max_speed)

func ent_dist(pos1: Vector2, pos2: Vector2):
	return (pos1 - pos2).length()


func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func physics_update(delta: float) -> void:
	if owner.is_dead():
		state_machine.transition_to("Death")
		return
	
	var target_pos = Global.get_closest_player(owner.global_position)
	var total_vector
		
	# direction of motion
	var vector_to_target = target_pos - owner.global_position
	
	if ent_dist(owner.global_position, target_pos) < 50:
		total_vector = -vector_to_target
	else:
		total_vector = vector_to_target

	# moving into the direction
	move_according_to(total_vector)

	if owner.bodies_in_engage_area > 0:
		state_machine.transition_to("Attack")
		return
