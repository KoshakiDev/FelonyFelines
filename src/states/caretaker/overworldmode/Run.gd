extends State


func enter(msg := {}) -> void:
	owner.legAnimationPlayer.play("run")
	owner.armAnimationPlayer.play("run")
	owner.headAnimationPlayer.play("look_straight")
	

func physics_update(delta: float) -> void:
	owner.control_card.show_card()
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_action_strength("right_1") - Input.get_action_strength("left_1")
	input_direction.y = Input.get_action_strength("down_1") - Input.get_action_strength("jump_1")
	owner.velocity = owner.velocity.linear_interpolate(input_direction * owner.run_speed, .1 if input_direction.length() > 0 else .2)
	
	if input_direction.x != 0:
		owner.whole_body.scale.x = input_direction.x
	
	owner.velocity = owner.move_and_slide(owner.velocity)
	
	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		state_machine.transition_to("Idle")

func exit():
	owner.legAnimationPlayer.stop()
	owner.armAnimationPlayer.stop()
	owner.clear_body()
