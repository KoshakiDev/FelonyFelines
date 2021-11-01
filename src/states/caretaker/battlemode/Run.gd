extends State


func enter(msg := {}) -> void:
	owner.legAnimationPlayer.play("run")
	owner.armAnimationPlayer.play("run")
	owner.headAnimationPlayer.play("look_straight")
	

func physics_update(delta: float) -> void:
	owner.control_card.show_card()
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	var input_direction_x = (Input.get_action_strength("right_1") - Input.get_action_strength("left_1"))
	
	if input_direction_x != 0:
		owner.whole_body.scale.x = input_direction_x
	
	owner.velocity.x = owner.run_speed * input_direction_x
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump_1"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")

func exit():
	owner.legAnimationPlayer.stop()
	owner.armAnimationPlayer.stop()
	owner.clear_body()
