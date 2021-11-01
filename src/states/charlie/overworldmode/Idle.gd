extends PlayerCharlieStateOverworldMode

#Idle state

func enter(msg := {}) -> void:
	player.animationPlayer.play("idle")
	player.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("left_2") or Input.is_action_pressed("right_2") or Input.is_action_just_pressed("jump_2") or Input.is_action_pressed("down_2"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("action_2"):
		if player.enemyDetector.get_overlapping_bodies().size() > 0:
			var target
			for i in player.enemyDetector.get_overlapping_bodies():
				target = i
				break
			if Chip.is_with_charlie == true or target.get_is_controlled() == true:
				state_machine.transition_to("MoveChip")
