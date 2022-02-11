extends State

#NPC IDLE STATE

func enter(msg := {}) -> void:
	if owner.movement_player.current_animation == "Decel_1" or owner.movement_player.current_animation == "Decel_2":
		yield(owner.movement_player, "animation_finished")
	owner.play_animation("Idle", "Movement")
	state_machine.transition_to("Move", {Accel = true})

func physics_update(_delta: float) -> void:
	if owner.is_dead(): state_machine.transition_to("Death")
#	if Input.is_action_pressed("left" + owner.player_id) or Input.is_action_pressed("right" + owner.player_id) or Input.is_action_just_pressed("up" + owner.player_id) or Input.is_action_pressed("down" + owner.player_id):
#		state_machine.transition_to("Move", {Accel = true})
