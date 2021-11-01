extends State


func enter(msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	owner.torsoAnimationPlayer.play("land")
	yield(owner.torsoAnimationPlayer, "animation_finished")
	state_machine.transition_to("Idle")

func exit():
	owner.clear_body()
