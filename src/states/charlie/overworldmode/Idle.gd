extends State

#shared player idle state
export var player_id = ""

func enter(msg := {}) -> void:
	owner.play_animation("Idle")
	owner.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("left" + player_id) or Input.is_action_pressed("right" + player_id) or Input.is_action_just_pressed("up" + player_id) or Input.is_action_pressed("down" + player_id):
		state_machine.transition_to("Move")
	elif Input.is_action_just_pressed("action" + player_id):
		state_machine.transition_to("Action")
