extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death")
	pass
	
	
func delete_enemy():
	Global.main.update_points(100)
	Global.main.enemy_count = Global.main.enemy_count - 1
	if Global.main.enemy_count == 0:
		Global.main.update_wave()
	
	Global.main.update_board()
	
	owner.queue_free()
	
