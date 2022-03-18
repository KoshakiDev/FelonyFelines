extends "res://src/entities/items/base_templates/base_item/base_item.gd"


export var damage_value: float =  20
export var knockback_value: float = 50
export var recoil: float = 15

var weapon_owner: Node2D

func init(weapon_owner: Node2D) -> void:
	self.weapon_owner = weapon_owner

func action(subject):
	animation_machine.play_animation("Attack", "AnimationPlayer")
	weapon_owner.knockback += -1 * weapon_owner.movement_direction * recoil
	
func start_shooting() -> void:
	action(weapon_owner)
