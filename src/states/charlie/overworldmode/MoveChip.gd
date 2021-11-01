extends PlayerCharlieStateOverworldMode




var moving_animation = "insert"

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	if Chip.is_with_charlie == true:
		moving_animation = "insert"
		owner.control_card.hide_card()
	else:
		moving_animation = "extract"
		owner.control_card.show_card()
	player.animationPlayer.play(moving_animation)
	yield(player.animationPlayer, "animation_finished")
	state_machine.transition_to("Idle")

func transfer_chip():
	if player.enemyDetector.get_overlapping_bodies().size() > 0:
		var target
		for i in player.enemyDetector.get_overlapping_bodies():
			target = i
			break
		target.emit_signal("become_controlled")
