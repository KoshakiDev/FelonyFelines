extends State

#NPC ATTACK STATE

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Movement")

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	var target = Global.get_closest_enemy(owner.global_position)
	if target == null:
		state_machine.transition_to("Idle")
		return
	if !owner.is_target_in_aim(target) or owner.current_bodies_in_attack_range.size() == 0:
		state_machine.transition_to("Move")
		return
	owner.aim(target)



#var melee_weapons = ["FISTS", "AXE", "SPEAR", "SHIELD"]
#var long_range_weapons = ["REVOLVER", "SHOTGUN", "ASSAULTRIFLE", "MINIGUN"]
#
#
#func chooseLongRange():
#	while not owner.weapon_manager.cur_weapon.entity_name in long_range_weapons:
#		owner.switch_to_next_weapon()
#
#func chooseMelee():
#	while not owner.weapon_manager.cur_weapon.entity_name in melee_weapons:
#		owner.switch_to_next_weapon()
#
#func enter(msg := {}) -> void:
#	if owner.movement_player.current_animation == "Decel_1" or owner.movement_player.current_animation == "Decel_2":
#		yield(owner.movement_player, "animation_finished")
#	owner.play_animation("Idle", "Movement")
#	print("transitioned to attack")
#
#func exit() -> void:
#	pass
#
#func point_gun():
#	var target_pos = Global.get_closest_enemy(owner.global_position)
#	print("Shooting at ", target_pos)
#	owner.adjust_hand_rotation(target_pos)
#
#func physics_update(_delta: float) -> void:
#	if !owner.there_is_an_enemy_in_distance(64 * 100):
#		state_machine.transition_to("Move", {Accel = true})
#	chooseLongRange()
#	point_gun()
#	owner.action()
