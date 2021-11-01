extends State


func enter(msg := {}) -> void:
	owner.legAnimationPlayer.play("idle")
	owner.armAnimationPlayer.play("idle")
	owner.torsoAnimationPlayer.play("idle")
	owner.headAnimationPlayer.play("look_straight")
	owner.velocity = Vector2.ZERO


func physics_update(_delta: float) -> void:
	owner.control_card.show_card()
	if Input.is_action_pressed("left_1") or Input.is_action_pressed("right_1") or Input.is_action_just_pressed("jump_1") or Input.is_action_pressed("down_1"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("action_1"):
		#owner.emit_signal("become_controlled")
		pass
		
func exit():
	owner.clear_body()
