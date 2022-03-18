extends "res://src/entities/base_templates/base_npc/base_npc.gd"

onready var handgun = $Visuals/Sprite/HandGun

var label: Label
onready var bullet_spawner = $Visuals/Sprite/HandGun/BulletSpawner

func _ready():
	if $Debug.has_node("Label"):
		label = $Debug/Label

func attack(target):
	var look_dir = (target.global_position - global_position).normalized()
	if look_dir.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	if sprite.scale.x == -1:
		handgun.rotation = PI - (target.global_position - global_position).angle()
	elif sprite.scale.x == 1:
		handgun.rotation = (target.global_position - global_position).angle()
	bullet_spawner.set_shooting(true)
