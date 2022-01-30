extends State


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
	if owner.is_dead(): return
	
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_action_strength("right" + owner.player_id) - Input.get_action_strength("left" + owner.player_id)
	input_direction.y = Input.get_action_strength("down" + owner.player_id) - Input.get_action_strength("up" + owner.player_id)
	
	owner.velocity = owner.velocity.linear_interpolate(input_direction * owner.max_speed, .1 if input_direction.length() > 0 else .2)

	if not(is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0)):
		owner.movement_direction = input_direction
	
	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		state_machine.transition_to("Idle")
