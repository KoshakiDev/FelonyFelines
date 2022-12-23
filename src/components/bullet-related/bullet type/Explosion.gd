extends "res://src/components/hitbox-hurtbox/hitbox/Hitbox.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Explode")
