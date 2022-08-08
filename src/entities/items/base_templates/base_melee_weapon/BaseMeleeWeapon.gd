extends "res://src/entities/items/base_templates/base_item/base_item.gd"


export var damage_value: float =  20
export var knockback_value: float = 50
export var recoil: float = 15

onready var swoosh_sound = $Position2D/SoundMachine/Swoosh

func action()-> void:
	animation_machine.play_animation("Attack", "AnimationPlayer")
	weapon_owner.knockback += -1 * weapon_owner.movement_direction * recoil
	swoosh_sound.play()
