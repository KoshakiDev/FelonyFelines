extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")

func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	
	var target = Global.get_closest_player(owner.global_position)
	if target != null:
		state_machine.transition_to("Chase")
		return
