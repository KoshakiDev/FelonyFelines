extends "res://src/entities/base_templates/base_npc/base_npc.gd"

export var cooldown_duration: float = 5

export var dash_duration: float = 3
export var dash_speed: int = 30

onready var hitbox = $Areas/Hitbox
onready var hitbox_shape = $Areas/Hitbox/HitboxShape

export var damage_value: float = 10
export var knockback_value: float = 20

#SOUNDS


func attack(target):
	pass
	
func _on_Hurtbox_area_entered(area):
	if health_manager.is_dead(): return
	._on_Hurtbox_area_entered(area)
	state_machine.transition_to("Pain")
	Global.frame_freeze(0.5, 2)

	
