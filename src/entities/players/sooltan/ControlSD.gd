extends Sprite

func _ready():
	pass
	
func action():
	#print("Insert chip!")

	var enemies = owner.find_targets_in_area(["enemy"], owner.hit_range)
	if enemies.size() == 0:
		return
	var enemy = enemies[0]
	
	
	Global.main.update_currently_controlled(enemy.type)
	enemy.insert_control_sd()
	enemy.add_to_group("player2")
	enemy.remove_from_group("enemy")

	var chip_slot = owner.weapon_manager.WEAPON_SLOT.CONTROL_SD
	owner.weapon_manager.slots_unlocked[chip_slot] = false
	owner.weapon_manager.switch_to_next_weapon()
	return
