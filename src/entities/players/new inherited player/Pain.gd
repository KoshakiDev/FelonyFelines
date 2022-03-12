extends State

func enter(msg := {}) -> void:
	if msg.has("Front"):
		owner.play_animation("Hit_Front", "Movement")
	elif msg.has("Back"):
		owner.play_animation("Hit_Back", "Movement")
	yield(owner.animation_machine.get_node("Movement"), "animation_finished")
	state_machine.transition_to("Idle")

