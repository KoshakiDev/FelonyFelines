extends "res://src/entities/objects/weapons/range/rangeModule.gd"

export var weapon_name := "SNIPER_RIFLE"

onready var animation_player := $AnimationPlayer

func action():
	animation_player.play("Shoot")
	pass
