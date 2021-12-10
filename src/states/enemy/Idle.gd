extends State

#shared player idle state
export var player_id = "_1"

func enter(msg := {}) -> void:
	owner.play_animation("Idle")

func physics_update(_delta: float) -> void:
	if owner.controlled:
		if Input.is_action_pressed("left" + player_id) or Input.is_action_pressed("right" + player_id) or Input.is_action_just_pressed("up" + player_id) or Input.is_action_pressed("down" + player_id):
			state_machine.transition_to("Move")
		else:
			state_machine.transition_to("Idle")
	else:
		if owner.find_targets_in_area(["player1", "player2"], owner.vision_area).size() != 0:
			state_machine.transition_to("Chase")
		else:
			state_machine.transition_to("Idle")
	
