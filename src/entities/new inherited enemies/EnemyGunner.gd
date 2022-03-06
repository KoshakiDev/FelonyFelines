extends "res://src/entities/base_templates/base_npc/base_npc.gd"

onready var gunhand = $Visuals/Sprite/GunHand/Shoulder1/Cannon

onready var label = $Debug/Label
onready var bullet_spawner = $Visuals/Sprite/GunHand/Shoulder1/Cannon/BulletSpawner

func attack(target):
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
