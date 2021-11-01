extends Node2D

onready var attackRay1 = $AttackRay1
onready var attackRay2 = $AttackRay2

func are_rays_colliding():
	if attackRay1.is_colliding() or attackRay2.is_colliding():
		return true
	else:
		return false
		

func get_colliding_rays():
	if attackRay1.is_colliding():
		return "AttackRay1"
	if attackRay2.is_colliding():
		return "AttackRay2"
