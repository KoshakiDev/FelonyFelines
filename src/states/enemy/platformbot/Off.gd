extends PlatformBotState


func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	if player.get_is_controlled():
		state_machine.transition_to("Idle")
