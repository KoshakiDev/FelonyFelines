extends State

#NPC ATTACK STATE

var close_range_weapons = ["FISTS", "AXE", "SPEAR", "SHIELD"]
var long_range_weapons = ["REVOLVER", "SHOTGUN", "ASSAULTRIFEL", "MINIGUN"]

func chooseWeapon():
	var enemy_position = Global.get_closest_enemy(owner.global_position)
	var distance = enemy_position.distance_to(owner.global_position)
	
	if distance > 100:
		while not owner.weapon_manager.cur_weapon.entity_name in long_range_weapons:			
			owner.switch_to_next_weapon()
	else:
		while not owner.weapon_manager.cur_weapon.entity_name in close_range_weapons:
			owner.switch_to_next_weapon()

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Movement")
	chooseWeapon()
	owner.action()
	state_machine.transition_to("Move")

func exit() -> void:
	pass
	


#don't use this not finished
func physics_update(_delta: float) -> void:
	pass
#	var target_pos = Global.get_closest_enemy(owner.global_position)
#	owner.hand_position.look_at(target_pos)
#
#	var look_dir = (target_pos - owner.global_position).normalized()
#	if look_dir.x < 0:
#		owner.sprite.scale.x = -1
#	else:
#		owner.sprite.scale.x = 1
#	owner.action()
#	if owner.bodies_in_engage_area <= 0:
#		state_machine.transition_to("Move")
