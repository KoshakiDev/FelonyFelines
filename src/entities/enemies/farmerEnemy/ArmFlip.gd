extends Node2D

onready var armSprite = $Sprite

func flip(direction):
	if direction == -1:
		self.rotation_degrees = self.rotation_degrees - 90
	else:
		self.rotation_degrees = self.rotation_degrees + 90
	self.scale.x = direction
	
func set_motion_blur():
	armSprite.material.set_shader_param("strength", 0.5)

func remove_motion_blur():
	armSprite.material.set_shader_param("strength", 0)

