extends Sprite

func _ready():
	pass
	
func action():
	print("Insert chip!")
	
	var enemy = owner.enemies_detection_system()[0]
	enemy.controlled = true

	owner.weapon_manager.slots_unlocked[owner.weapon_manager.cur_slot] = false
	owner.weapon_manager.switch_to_next_weapon()
	return
