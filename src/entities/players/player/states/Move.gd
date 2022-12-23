extends State


func enter(msg := {}) -> void:
	owner.play_animation("Accel", "Movement")
	yield(owner.get_animation_player("Movement"), "animation_finished")
	owner.play_animation("Run", "Movement")


func exit() -> void:
	owner.play_animation("Decel", "Movement")
	yield(owner.get_animation_player("Movement"), "animation_finished")

	
func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead(): state_machine.transition_to("Death")
	
	if owner.interacting:
		state_machine.transition_to("Interacting")
	
	
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_action_strength("right" + owner.player_id) - Input.get_action_strength("left" + owner.player_id)
	input_direction.y = Input.get_action_strength("down" + owner.player_id) - Input.get_action_strength("up" + owner.player_id)
	
	owner.movement.move(input_direction)
	#owner.sound_machine.play_sound("Footstep")
	
	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		state_machine.transition_to("Idle")
