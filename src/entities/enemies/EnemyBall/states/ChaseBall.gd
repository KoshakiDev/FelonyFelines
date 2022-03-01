extends State

func move(direction):
	owner.velocity = owner.velocity.linear_interpolate(direction * owner.max_speed, Global.ACCEL)
	owner.movement_direction = direction

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func physics_update(delta: float) -> void:
	if owner.is_dead():
		print("dead")
		state_machine.transition_to("Death")
		return
	var target_pos = Global.get_farthest_player(owner.global_position)
	var total_vector
	owner.get_target_path(target_pos)
	# direction of motion
	if owner.path.size() > 0:
		var vector_to_target = owner.get_next_direction_to_target()
		move(vector_to_target)

	if owner.bodies_in_engage_area > 0:
		state_machine.transition_to("Attack")
		return
