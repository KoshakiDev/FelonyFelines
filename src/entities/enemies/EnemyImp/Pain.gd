extends State

func enter(msg := {}) -> void:
	owner.play_animation("Hit", "Animations")
	yield(owner.animation_machine.get_node("Animations"), "animation_finished")
	state_machine.transition_to("Idle")

