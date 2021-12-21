extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death", "Movement")
	pass
	
func delete_player():
	owner.queue_free()
