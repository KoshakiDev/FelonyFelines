extends "res://src/weapons/melee/meleeModule.gd"

export var weapon_name := "AXE"

onready var hitbox := $AxeSprite/Hitbox
onready var animation_player := $AnimationPlayer

func action():
	animation_player.play("Attack")
