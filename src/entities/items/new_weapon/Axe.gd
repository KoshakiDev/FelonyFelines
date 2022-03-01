extends "res://src/entities/items/base_templates/base_melee_weapon/BaseMeleeWeapon.gd"

func _ready():
	pass # Replace with function body.

func action(_subject):
	_subject.knockback += _subject.movement_direction * recoil
	animation_machine.play_animation("Attack", "AnimationPlayer")
