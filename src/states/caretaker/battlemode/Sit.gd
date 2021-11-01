extends State


func enter(msg := {}) -> void:
	owner.torsoAnimationPlayer.play("sit")
	owner.headAnimationPlayer.play("look_up")
	owner.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	owner.control_card.show_card()
	if Input.is_action_just_pressed("jump_1"):
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("left_1") or Input.is_action_pressed("right_1"):
		state_machine.transition_to("Run")

func exit():
	if owner.get_is_controlled():
		owner.torsoAnimationPlayer.stop()
		owner.clear_body()
	
