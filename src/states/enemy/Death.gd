extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death")
	yield(owner.anim_player, "animation_finished")
	delete_enemy()
	pass
	
	
func delete_enemy():
	owner.queue_free()
	
