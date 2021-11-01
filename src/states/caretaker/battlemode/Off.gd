extends State


func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	owner.torsoAnimationPlayer.play(owner.torsoAnimationPlayer.current_animation + "_off")
	owner.modulateAnimationPlayer.play("normal_to_purple")
	owner.headAnimationPlayer.play("look_down_transition")
	yield(owner.modulateAnimationPlayer, "animation_finished")
	yield(owner.headAnimationPlayer, "animation_finished")
	#owner.modulateAnimationPlayer.play("stay_purple")
	owner.headAnimationPlayer.play("look_down")
	
	
	
func physics_update(_delta: float) -> void:
	owner.control_card.hide_card()
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	if owner.get_is_controlled():
		state_machine.transition_to("Idle")

func exit():
	owner.modulateAnimationPlayer.play("purple_to_normal")
	owner.headAnimationPlayer.play("look_straight_transition")
	yield(owner.modulateAnimationPlayer, "animation_finished")
	yield(owner.headAnimationPlayer, "animation_finished")
	#owner.clear_body()
