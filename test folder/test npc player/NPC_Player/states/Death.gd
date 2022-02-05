extends State

#NPC DEATH STATE

func enter(msg := {}) -> void:
	owner.play_animation("Death", "Movement")
	owner._turn_off_all()
	yield(owner.movement_player, "animation_finished")
