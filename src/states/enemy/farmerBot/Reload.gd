extends PlatformBotState

var direction_x
#Reload
func enter(_msg := {}) -> void:
	player.armAnimation.play("gunReload")
	player.velocity = Vector2.ZERO
	yield(player.animationPlayer, "animation_finished")
	state_machine.transition_to("Idle")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
