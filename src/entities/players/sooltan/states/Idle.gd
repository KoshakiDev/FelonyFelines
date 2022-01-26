extends State

func enter(msg := {}) -> void:
	if msg.has("decel"):
		if msg["decel"] == "Run_1":
			owner.play_animation("Decel_1", "Movement")
		elif msg["decel"] == "Run_2":
			owner.play_animation("Decel_2", "Movement")
		yield(owner.movement_player, "animation_finished")
	else:
		owner.play_animation("Idle", "Movement")

func physics_update(_delta: float) -> void:
	if owner.is_dead(): state_machine.transition_to("Death")
	if Input.is_action_pressed("left" + owner.player_id) or Input.is_action_pressed("right" + owner.player_id) or Input.is_action_just_pressed("up" + owner.player_id) or Input.is_action_pressed("down" + owner.player_id):
		state_machine.transition_to("Move")	
