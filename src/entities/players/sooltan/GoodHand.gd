extends Sprite

func _ready():
	pass
	
func action():
	print("Take chip or do nothing")

	var enemies = owner.enemies_detection_system()
	for enemy in enemies:
		if enemy.controlled:
			# TODO: Find a way to get chips slot id, better
			var chip_slot = # ???
			owner.weapon_manager.slots_unlocked[chip_slot] = true
			owner.weapon_manager.switch_to_weapon_slot(chip_slot)
	return
