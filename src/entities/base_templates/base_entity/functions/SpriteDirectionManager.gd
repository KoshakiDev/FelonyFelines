extends Node

func adjust_direction(velocity_vector):
	owner.movement_direction = vec_to_dir(velocity_vector)
	if owner.movement_direction.x != 0:
		owner.sprite.scale.x = owner.movement_direction.x
	if owner.is_in_group("PLAYER"):
		adjust_weapon_rotation(owner.movement_direction)

func adjust_weapon_rotation(direction):
	owner.weapon_manager.look_at(owner.weapon_manager.global_position + direction)

func vec_to_dir(vec : Vector2)->Vector2:
	if vec == Vector2.ZERO:
		return Vector2.ZERO
	var ass = abs(vec.aspect())
	var res = vec.sign()
	if ass < 0.557852 or ass > 1.79259:
		res[int(ass > 1.0)] = 0
	return res
