extends State

#NPC MOVE STATE

func spiral(direction_vector):
	var x = direction_vector.x
	var y = direction_vector.y
	
	return Vector2(y, -x) * 0.8

func move(direction):
	owner.velocity = owner.velocity.linear_interpolate(direction * owner.max_speed, Global.ACCEL)
	owner.movement_direction = direction


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
	
	#print(owner.there_is_an_enemy_in_distance(100))
	# Okay, look, the amount it gives back is in TILES (64) length
	print(owner.there_is_an_enemy_in_distance(64 * 100))
	if owner.there_is_an_enemy_in_distance(64 * 100):
		# attack closest enemy
		state_machine.transition_to("Attack")
	elif owner.health < 90 && owner.is_there_item("MEDKIT"):
		# go to the box
		# target_pos = position_of_box()
		target_pos = owner.return_item_position("MEDKIT")
	elif owner.is_there_item("WEAPON"):
		target_pos = owner.return_item_position("WEAPON")
	elif brother.is_dead():
		# go to brother
		target_pos = brother.global_position
	else:
		target_pos = Global.get_closest_enemy(owner.global_position)
		#state_machine.transition_to("Idle")

		
	owner.get_target_path(target_pos)
	# direction of motion
	if owner.path.size() > 0:
		vector_to_target = owner.get_next_direction_to_target()
		move(vector_to_target)
