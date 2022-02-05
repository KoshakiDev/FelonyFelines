extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")
	owner.bullet_spawner.set_shooting(true)

func exit() -> void:
	owner.cannon.rotation_degrees = 0
	owner.bullet_spawner.set_shooting(false)

func physics_update(_delta: float) -> void:	
	var target_pos = Global.get_closest_player(owner.global_position)

	owner.hand_position.look_at(target_pos)
	var look_dir = (target_pos - owner.global_position).normalized()
	if look_dir.x < 0:
		owner.sprite.scale.x = -1
	else:
		owner.sprite.scale.x = 1
		
	if owner.bodies_in_engage_area  == 0:
		state_machine.transition_to("Chase")
