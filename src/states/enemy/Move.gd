extends State

#shared player move state

export var player_id = "_1"

func enter(msg := {}) -> void:
	owner.play_animation("Run")
	

func physics_update(delta: float) -> void:
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_action_strength("right" + player_id) - Input.get_action_strength("left" + player_id)
	input_direction.y = Input.get_action_strength("down" + player_id) - Input.get_action_strength("up" + player_id)
	owner.velocity = owner.velocity.linear_interpolate(input_direction * owner.run_speed, .1 if input_direction.length() > 0 else .2)
	
	if input_direction != Vector2.ZERO:
		owner.adjust_blend_position(input_direction)
	owner.velocity = owner.move_and_slide(owner.velocity)
		
	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		state_machine.transition_to("Idle")
