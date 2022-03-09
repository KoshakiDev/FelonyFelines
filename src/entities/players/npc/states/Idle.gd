extends State

#NPC IDLE STATE

func enter(msg := {}) -> void:
	if owner.get_animation_player("Movement").current_animation == "Decel_1" or owner.get_animation_player("Movement").current_animation == "Decel_2":
		yield(owner.get_animation_player("Movement"), "animation_finished")
	owner.play_animation("Idle", "Movement")

func physics_update(_delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	
	var target = Global.get_closest_enemy(owner.global_position)
	if target != null:
		state_machine.transition_to("Move")
		return
	
#	if owner.there_is_an_enemy_in_distance(64 * 100):
#		state_machine.transition_to("Attack")
#	elif owner.health < 90 && owner.is_there_item("MEDKIT"):
#		state_machine.transition_to("Move", {Accel = true})
#	elif owner.is_there_item("WEAPON"):
#		state_machine.transition_to("Move", {Accel = true})
#	elif Global.get_brother().is_dead():
#		state_machine.transition_to("Move", {Accel = true})
