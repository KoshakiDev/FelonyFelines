extends "res://src/entities/base_templates/base_npc/base_npc.gd"

onready var gunhand = $Visuals/Sprite/GunHand/Shoulder1/Cannon

onready var label = $Debug/Label
onready var bullet_spawner = $Visuals/Sprite/GunHand/Shoulder1/Cannon/BulletSpawner

var hit_pos = []

func is_target_in_aim(target):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.hurtbox_shape.shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(position,
				pos, [self], collision_mask)
		#print(result)
		if result:
			hit_pos.append(result.position)
			if !result.collider.get("entity_type"):
				break
			if result.collider.entity_type == "PLAYER":
				return true
	return false


func aim(target):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.hurtbox_shape.shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(global_position,
				pos, [self], collision_mask)
		#print(result)
		if result:
			hit_pos.append(result.position)
			if !result.collider.get("entity_type"):
				break
			if result.collider.entity_type == "PLAYER":
				var look_dir = (target.global_position - global_position).normalized()
				if look_dir.x < 0:
					sprite.scale.x = -1
				else:
					sprite.scale.x = 1
				
				if sprite.scale.x == -1:
					gunhand.rotation = PI - (target.global_position - global_position).angle()
				elif sprite.scale.x == 1:
					gunhand.rotation = (target.global_position - global_position).angle()
				bullet_spawner.set_shooting(true)
				break
