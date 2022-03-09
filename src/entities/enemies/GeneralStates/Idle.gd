extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func physics_update(_delta: float) -> void:
	
	var vector_to_center = Vector2.ZERO - owner.global_position
	if owner.find_targets_in_area(["player"], owner.vision_area).size() == 0:
		state_machine.transition_to("Idle")
	else:
		state_machine.transition_to("Chase")
