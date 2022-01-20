extends State

func enter(msg := {}) -> void:
	owner.play_animation("Death", "Movement")
	owner._turn_off_all()
	
