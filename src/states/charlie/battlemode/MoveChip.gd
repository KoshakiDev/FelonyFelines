extends State

var moving_animation = "insert"

func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	if Chip.is_with_charlie == true:
		moving_animation = "insert"
		owner.control_card.hide_card()
	else:
		moving_animation = "extract"
		owner.control_card.show_card()
	owner.animationPlayer.play(moving_animation)
	yield(owner.animationPlayer, "animation_finished")
	state_machine.transition_to("Idle")

func transfer_chip():
	if owner.enemyDetector.is_colliding():
		owner.enemyDetector.get_collider().emit_signal("become_controlled")
