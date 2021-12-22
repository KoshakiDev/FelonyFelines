extends "res://src/entities/objects/weapons/range/rangeModule.gd"

export var weapon_name := "SNIPER_RIFLE"

onready var animation_player := $AnimationPlayer

onready var bullet_spawner := $BulletSpawner

export var bullet_speed: float = 400


func action():
	animation_player.play("Shoot")

func bullet_spawner_set_shooting_true():
	bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	bullet_spawner.set_shooting(false)
