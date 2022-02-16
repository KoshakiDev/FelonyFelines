extends State

#NPC MOVE STATE

func spiral(direction_vector):
	var x = direction_vector.x
	var y = direction_vector.y
	
	return Vector2(y, -x) * 0.8

func there_is_an_enemy_in_distance(distance):
	var closest_enemy_position = Global.get_closest_enemy(owner.global_position)
	var path = Global.navigation.get_simple_path(owner.global_position, closest_enemy_position, false)
	var path_length = 0
	
	if path.size() > 0:
		for i in range(path.size() - 1):
			path_length += (path[i] - path[i-1]).length()
			
	if path_length < distance:
		return true
	else:
		return false

func there_is_an_enemy_in_attack_angle():
	var closest_enemy_position = Global.get_closest_enemy(owner.global_position)
	var angle_rad = (owner.global_position - closest_enemy_position).angle()
	var angle_deg = int(abs(angle_rad * (180/PI)))
	
	return angle_deg % 45 < 3

func is_there_item(target_item):
	#the target item name must match the existing item types 
	for item in Global.items.get_children():
		if item.item_type == target_item:
			return true
	return false

func return_item_position(target_item):
	#the target item name must match the existing item types 
	var target_item_position = Vector2.ZERO
	#print(Global.items.get_children())
	for item in Global.items.get_children():
		if item.item_type == target_item:
			target_item_position = item.global_position
	return target_item_position


func seek_steering(desired_direction_vector: Vector2) -> Vector2:
	var desired_velocity: Vector2 = desired_direction_vector.normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func move_according_to(vector):
	var steering: Vector2 = seek_steering(vector)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering
	owner.velocity = owner.velocity.linear_interpolate(vector * owner.max_speed, .1 if vector.length() > 0 else .2)
	
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
		state_machine.transition_to("Death")
		return
	
	var target_pos = Vector2.ZERO
	var vector_to_target
	var total_vector
	
	var attack = false
	var brother = Global.get_brother()
	
	if there_is_an_enemy_in_distance(100) or (there_is_an_enemy_in_distance(500) and there_is_an_enemy_in_attack_angle()):
		# attack closest enemy
		attack = true
		target_pos = Global.get_closest_enemy(owner.global_position)
	elif owner.health < 90 && is_there_item("MEDKIT"):
		# go to the box
		# target_pos = position_of_box()
		target_pos = return_item_position("MEDKIT")
	elif is_there_item("WEAPON"):
		target_pos = return_item_position("WEAPON")
	elif brother.is_dead():
		# go to brother
		target_pos = brother.global_position
	else:
		# go to closest enemy
		target_pos = Global.get_closest_enemy(owner.global_position)

		
	if not attack:
		owner.get_target_path(target_pos)
		# direction of motion
		if owner.path.size() > 0:
			vector_to_target = owner.get_next_direction_to_target()
			total_vector = vector_to_target

			# moving into the direction
			move_according_to(total_vector)
			owner.movement_direction = vector_to_target
	else:
		vector_to_target = target_pos - owner.global_position
		total_vector = vector_to_target
		owner.movement_direction = vector_to_target
		state_machine.transition_to("Attack")
