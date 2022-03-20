extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return

	var target = Global.get_farthest_player(owner.global_position)
	var total_vector
	
	if target == null:
		state_machine.transition_to("Idle")
		return
	if owner.is_target_in_aim(target) and owner.current_bodies_in_attack_range.size() > 0:
		state_machine.transition_to("Attack")
		return
	var target_pos = target.global_position
	
	if owner.nav_manager.can_update_path:
		owner.nav_manager.get_target_path(target_pos)
		owner.nav_manager.update_path_timer.start()
	# direction of motion
	if owner.nav_manager.path.size() > 0:
		var vector_to_target = owner.nav_manager.get_next_direction_to_target()
		if vector_to_target:
			total_vector = vector_to_target
			owner.move(vector_to_target)

