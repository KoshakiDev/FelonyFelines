extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death")
	pass
	
	
func delete_enemy():
	Global.main.update_points(100)
	if owner.controlled:
		Global.main.update_currently_controlled("none")
	var chip_slot = Global.sooltan.weapon_manager.WEAPON_SLOT.CONTROL_SD
	Global.sooltan.weapon_manager.slots_unlocked[chip_slot] = true
	owner.queue_free()
	
