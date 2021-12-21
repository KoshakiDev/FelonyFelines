extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death", "Movement")
	if owner.is_stationary:
		Global.reparent(Global.brother_1, Global.parent_location)

func delete_player():
	owner.queue_free()
