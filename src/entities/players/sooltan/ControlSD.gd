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

	# TODO: Find a way to find chip slot id, better
	var chip_slot = owner.weapon_manager.cur_slot
	owner.weapon_manager.slots_unlocked[chip_slot] = false
	owner.weapon_manager.switch_to_next_weapon()
	return
