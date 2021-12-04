extends State

func enter(msg := {}) -> void:
#	owner.play_animation("Death")
	delete_enemy()
	pass
	
	
func delete_enemy():
	owner.queue_free()
