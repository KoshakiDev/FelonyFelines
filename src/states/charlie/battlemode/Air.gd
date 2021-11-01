extends State

var fall = "fall"

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		fall = "rise"
		owner.velocity.y = -owner.jump_impulse
	owner.animationPlayer.play(fall)
	fall = "fall"
	
		
func physics_update(delta):
	var input_direction_x: float = (
		Input.get_action_strength("right_2")
		- Input.get_action_strength("left_2")
	)
	if input_direction_x != 0:
		owner.enemyDetector.scale.y = input_direction_x
		owner.sprite.scale.x = input_direction_x
	
	owner.velocity.x = owner.run_speed * input_direction_x
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle", {do_land = true})
		else:
			state_machine.transition_to("Run")
