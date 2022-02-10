extends State

#NPC MOVE STATE

var rng = RandomNumberGenerator.new()
func random_vector2(n):
	rng.randomize()
	return Vector2(rng.randf_range(-n, n), rng.randf_range(-n, n))

func spiral(direction_vector):
	var x = direction_vector.x
	var y = direction_vector.y
	
	return Vector2(y, -x) * 0.8

func there_is_an_enemy_in_distance(distance):
	var closest_enemy_position = Global.get_closest_enemy(owner.global_position)
	if (closest_enemy_position - owner.global_position).length() < distance:
		return true
	else:
		return false

func there_is_a_box():
	return false

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
	
	var target_pos = Vector2.ZERO
	var vector_to_target
	var total_vector

	var brother = Global.get_brother()	
	
	if there_is_an_enemy_in_distance(50):
		# attack closest enemy
		state_machine.transition_to("Attack")
		return
	elif there_is_an_enemy_in_distance(300):
		# go to closest enemy
		target_pos = Global.get_closest_enemy(owner.global_position)
	elif owner.health < 50 && there_is_a_box():
		# go to the box
		# target_pos = position_of_box()
		target_pos = Vector2.ZERO
	elif brother.is_dead():
		# go to brother
		target_pos = brother.global_position
	else:
		# go random
		target_pos = random_vector2(2) + owner.movement_direction * 1 + owner.global_position * 0.99
	
	# direction of motion
	vector_to_target = target_pos - owner.global_position
	total_vector = vector_to_target

	# moving into the direction
	move_according_to(total_vector)
	owner.movement_direction = vector_to_target
