extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")

func physics_update(_delta: float) -> void:
	if owner.find_targets_in_area(["player"], owner.vision_area).size() == 0:
		state_machine.transition_to("Idle")
	else:
		state_machine.transition_to("Chase")
