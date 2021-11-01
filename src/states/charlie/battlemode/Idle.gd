extends State

#Idle state

func enter(msg := {}) -> void:
	if msg.has("do_land"):
		owner.animationPlayer.play("land")
		yield(owner.animationPlayer, "animation_finished")
	owner.animationPlayer.play("idle")
	owner.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	if Input.is_action_just_pressed("jump_2"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("left_2") or Input.is_action_pressed("right_2"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("action_2"):
		if owner.enemyDetector.is_colliding() == true:
			if Chip.is_with_charlie == true or owner.enemyDetector.get_collider().get_is_controlled() == true:
				state_machine.transition_to("MoveChip")
