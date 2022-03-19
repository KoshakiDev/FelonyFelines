extends State

func enter(msg := {}) -> void:
	if msg.has("Front"):
		owner.play_animation("Hit_Front", "Animations")
	elif msg.has("Back"):
		owner.play_animation("Hit_Back", "Animations")
	yield(owner.animation_machine.get_node("Animations"), "animation_finished")
	state_machine.transition_to("Idle")
