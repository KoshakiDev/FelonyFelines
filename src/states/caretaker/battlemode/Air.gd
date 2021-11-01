extends State

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		owner.velocity.y = -owner.jump_impulse
		owner.legAnimationPlayer.play("jump")
		owner.armAnimationPlayer.play("jump")
		owner.headAnimationPlayer.play("look_up")
	else:
		owner.legAnimationPlayer.play("air")
		owner.armAnimationPlayer.play("air")
		owner.headAnimationPlayer.play("look_down")

func physics_update(delta):
	var input_direction_x: float = (
		Input.get_action_strength("right_1")
		- Input.get_action_strength("left_1")
	)
	if input_direction_x != 0:
		owner.whole_body.scale.x = input_direction_x
	owner.velocity.x = owner.run_speed * input_direction_x
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Land")
		else:
			state_machine.transition_to("Run")
			
func exit():
	owner.clear_body()
