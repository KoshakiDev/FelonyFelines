extends State

#NPC DEATH STATE

func enter(msg := {}) -> void:
	owner._turn_off_all()
	owner.play_animation("Death", "Movement")
	yield(owner.animation_machine.get_node("Movement"), "animation_finished")
