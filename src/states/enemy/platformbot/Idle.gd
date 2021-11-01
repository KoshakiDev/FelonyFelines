extends PlatformBotState

#Idle state

func enter(_msg := {}) -> void:
	if !player.get_is_controlled():
		player.idleTimer.start()
	player.animationPlayer.play("idle")
	if !player.has_gun:
		player.armAnimation.play("armIdle")
	else:
		player.armAnimation.play("gunIdle")
	player.velocity = Vector2.ZERO
	


func physics_update(_delta: float) -> void:
	if !player.get_is_controlled():
		not_controlled(_delta)
	else:
		controlled(_delta)
	
func not_controlled(_delta: float) -> void:
	player.control_card.hide_card()
	player.attack()
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		player.idleTimer.stop()
		return
	player.velocity = Vector2.ZERO

func controlled(_delta: float) -> void:
	player.control_card.show_card()
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	if Input.is_action_just_pressed("jump_1"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("left_1") or Input.is_action_pressed("right_1"):
		state_machine.transition_to("Walk")
