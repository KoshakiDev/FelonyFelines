extends "res://src/components/bullet-related/bullet type/BaseProjectile.gd"

export var EXPLOSION_SCENE: PackedScene

func _on_Bullet_area_entered(area):
	explode()

func explode():
	print("boom")
	var boom: Area2D = EXPLOSION_SCENE.instance()
	boom.position = global_position
	Global.misc.add_child(boom)
	queue_free()


func _on_Bullet_body_entered(body):
	explode()
