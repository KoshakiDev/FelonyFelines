extends State

#NPC ATTACK STATE

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Movement")
	owner.action()

func exit() -> void:
	pass



#don't use this not finished
func physics_update(_delta: float) -> void:
	var target_pos = Global.get_closest_enemy(owner.global_position)
	owner.hand_position.look_at(target_pos)
	
	var look_dir = (target_pos - owner.global_position).normalized()
	if look_dir.x < 0:
		owner.sprite.scale.x = -1
	else:
		owner.sprite.scale.x = 1

	if owner.bodies_in_engage_area <= 0:
		state_machine.transition_to("Move")
