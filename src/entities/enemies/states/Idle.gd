extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")

func physics_update(_delta: float) -> void:
	if owner.is_vision_area_empty:
		state_machine.transition_to("Idle")
	else:
		state_machine.transition_to("Chase")
