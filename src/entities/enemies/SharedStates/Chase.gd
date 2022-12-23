extends State
"""
Shared Chase state for enemies
"""

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	"""
	if owner.nav_agent.is_navigation_finished():
		owner.nav_agent.can_update_path = true
		print("navigation finished")
		state_machine.transition_to("Idle")
		return
	"""
	
	var target = owner.search_for_target()
	if target == null:
		state_machine.transition_to("Idle")
		return
	
	if owner.is_target_in_aim(target) and owner.current_bodies_in_attack_range.size() > 0:
		state_machine.transition_to("Attack")
		return
	if owner.nav_agent.can_update_path:
		var target_pos = target.global_position
		owner.nav_agent.set_target_location(target_pos)
		owner.nav_agent.update_path_timer.start()
		
	var target_global_position = owner.nav_agent.get_next_location()
	var direction = owner.global_position.direction_to(target_global_position)
	owner.movement.move(direction)
	owner.nav_agent.set_velocity(owner.movement.intended_velocity)
	
