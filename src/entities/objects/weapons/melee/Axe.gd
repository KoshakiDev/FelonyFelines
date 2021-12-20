extends "res://src/entities/objects/weapons/melee/meleeModule.gd"

export var weapon_name := "AXE"

onready var hit_range := $AxeSprite/HitRange
onready var animation_player := $AnimationPlayer

func action():
	animation_player.play("Attack")
	var enemies = find_targets_in_area(["enemy"], hit_range)
	for enemy in enemies:
		enemy.take_damage(owner, damage_value, knockback_value)
	return
