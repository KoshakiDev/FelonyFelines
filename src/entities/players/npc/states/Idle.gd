extends State

#NPC IDLE STATE

func enter(msg := {}) -> void:
	if owner.movement_player.current_animation == "Decel_1" or owner.movement_player.current_animation == "Decel_2":
		yield(owner.movement_player, "animation_finished")
	owner.play_animation("Idle", "Movement")

func physics_update(_delta: float) -> void:
	if owner.is_dead(): state_machine.transition_to("Death")
	
	if owner.there_is_an_enemy_in_distance(64 * 100):
		state_machine.transition_to("Attack")
	elif owner.health < 90 && owner.is_there_item("MEDKIT"):
		state_machine.transition_to("Move", {Accel = true})
	elif owner.is_there_item("WEAPON"):
		state_machine.transition_to("Move", {Accel = true})
	elif Global.get_brother().is_dead():
		state_machine.transition_to("Move", {Accel = true})
	
