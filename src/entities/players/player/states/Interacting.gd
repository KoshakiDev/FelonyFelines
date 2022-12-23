extends State

func enter(msg := {}) -> void:
	if owner.get_animation_player("Movement").current_animation == "Decel":
		yield(owner.get_animation_player("Movement"), "animation_finished")
	owner.play_animation("Idle", "Movement")

func physics_update(_delta: float) -> void:
	if owner.health_manager.is_dead(): state_machine.transition_to("Death")
	
	if !owner.interacting:
		state_machine.transition_to("Idle")
	
