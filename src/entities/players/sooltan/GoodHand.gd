extends Sprite

func _ready():
	pass
	
func action():
	#print("Take chip or do nothing")

	var targets = owner.find_targets_in_area(["player2"], owner.hit_range)
	if targets.size() == 0:
		return
	
	var player = targets[0]
	
	var chip_slot = owner.weapon_manager.WEAPON_SLOT.CONTROL_SD
	owner.weapon_manager.slots_unlocked[chip_slot] = true
	owner.weapon_manager.switch_to_weapon_slot(chip_slot)
	
	
	Global.main.update_currently_controlled("none")
	player.extract_control_sd()
	player.add_to_group("enemy")
	player.remove_from_group("player2")
	
	player.state_machine.transition_to("Chase")
	
	return
