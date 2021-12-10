extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death")
	yield(owner.anim_player, "animation_finished")

	var chip_slot = Global.sooltan.weapon_manager.WEAPON_SLOT.CONTROL_SD
	Global.sooltan.weapon_manager.slots_unlocked[chip_slot] = true
	
	delete_enemy()
	pass
	
	
func delete_enemy():
	owner.queue_free()
	
