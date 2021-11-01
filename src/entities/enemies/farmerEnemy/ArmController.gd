extends Node2D

onready var armBack = $ArmBack
onready var armFront = $ArmFront

var is_flipped = false

func flip_arms(direction):
	self.scale.x = direction
