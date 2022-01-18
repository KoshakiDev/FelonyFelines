extends "res://src/entities/items/itemModules.gd"

func action(_subject):
	self.animation_player.play("Shoot") 

func bullet_spawner_set_shooting_true():
	self.bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	self.bullet_spawner.set_shooting(false)
