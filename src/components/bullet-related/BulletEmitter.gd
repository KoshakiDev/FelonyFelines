class_name BulletEmitter
extends Resource

var bullet_scene: PackedScene
var parent: Node2D

func setup(parent: Node2D, bullet_scene: PackedScene):
	self.parent = parent
	self.bullet_scene = bullet_scene

# needs to be overwritten by children!
func shoot(position: Vector2, dir: Vector2, speed: float, bullet_damage_value: int, knockback_value: int):
	pass

func shoot_single(position: Vector2, dir: Vector2, speed: float, bullet_damage_value: int, knockback_value: int):
	var bullet_instance = self.bullet_scene.instance()
	bullet_instance.setup(dir, speed, bullet_damage_value, knockback_value)
	#bullet_instance.set_as_toplevel(true)
	bullet_instance.global_position = position
	bullet_instance.shooting = true
	Global.projectiles.add_child(bullet_instance)
	#self.parent.add_child(bullet_instance) 
