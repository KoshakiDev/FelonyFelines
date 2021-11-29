extends Sprite

func _ready():
	pass
	
func action():
	print("Insert chip!")

	var enemies = owner.enemies_detection_system()
	if enemies.size() == 0:
		return
	var enemy = enemies[0]
	
	enemy.controlled = true
	enemy.add_to_group("player")

	print("players: ", get_tree().get_nodes_in_group("player"))

	var chip_slot = owner.weapon_manager.WEAPON_SLOT.CONTROL_SD
	owner.weapon_manager.slots_unlocked[chip_slot] = false
	owner.weapon_manager.switch_to_next_weapon()
	return
