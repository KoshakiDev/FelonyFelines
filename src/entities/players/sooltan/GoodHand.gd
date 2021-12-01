extends Sprite

func _ready():
	pass
	
func action():
	print("Take chip or do nothing")

	var enemies = owner.enemies_detection_system()
	for enemy in enemies:
		if enemy.controlled:
			var chip_slot = owner.weapon_manager.WEAPON_SLOT.CONTROL_SD
			owner.weapon_manager.slots_unlocked[chip_slot] = true
			owner.weapon_manager.switch_to_weapon_slot(chip_slot)
			
			enemy.extract_control_sd()
			enemy.remove_from_group("player")
			enemy.state_machine.transition_to("Chase")
			
			return
	return
