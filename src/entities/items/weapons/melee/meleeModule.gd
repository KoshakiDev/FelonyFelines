extends "res://src/entities/items/itemModules.gd"

export var damage_value: float =  20
export var knockback_value: float = 50

func action(_subject):
		self.animation_player.play("Attack")
