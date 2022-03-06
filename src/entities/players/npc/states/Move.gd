extends State

#NPC MOVE STATE
func enter(msg := {}) -> void:
	if msg.has("Accel"):
		owner.play_animation("Accel", "Movement")
		yield(owner.get_animation_player("Movement"), "animation_finished")
	if !owner.is_extra_resistance_on:
		owner.play_animation("Run_2", "Movement")
	else:
		owner.play_animation("Run_1", "Movement")

func exit() -> void:
	owner.play_animation("Decel_1", "Movement")

func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	var target = Global.get_closest_enemy(owner.global_position)
	var total_vector
	if target == null:
		state_machine.transition_to("Idle")
		return
	if owner.is_target_in_aim(target) and owner.current_bodies_in_attack_range.size() > 0:
		state_machine.transition_to("Attack")
		return
	var target_pos = target.global_position
	owner.nav_manager.get_target_path(target_pos)
	# direction of motion
	if owner.nav_manager.path.size() > 0:
		var vector_to_target = owner.nav_manager.get_next_direction_to_target()
		total_vector = vector_to_target
		owner.move(vector_to_target)
	

#	var brother = Global.get_brother()
#
#	#print(owner.there_is_an_enemy_in_distance(100))
#	# Okay, look, the amount it gives back is in TILES (64) length
#	print(owner.there_is_an_enemy_in_distance(64 * 100))
#	if owner.there_is_an_enemy_in_distance(64 * 100):
#		# attack closest enemy
#		state_machine.transition_to("Attack")
#	elif owner.health < 90 && owner.is_there_item("MEDKIT"):
#		# go to the box
#		# target_pos = position_of_box()
#		target_pos = owner.return_item_position("MEDKIT")
#	elif owner.is_there_item("WEAPON"):
#		target_pos = owner.return_item_position("WEAPON")
#	elif brother.is_dead():
#		# go to brother
#		target_pos = brother.global_position
#	else:
#		target_pos = Global.get_closest_enemy(owner.global_position)
#		#state_machine.transition_to("Idle")
#
#
#	owner.get_target_path(target_pos)
#	# direction of motion
#	if owner.path.size() > 0:
#		vector_to_target = owner.get_next_direction_to_target()
#		move(vector_to_target)


