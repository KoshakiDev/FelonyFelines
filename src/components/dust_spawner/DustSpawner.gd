extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var DUST_SCENE: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_dust() -> void:
	var dust: Sprite = DUST_SCENE.instance()
	dust.position = global_position
	Global.misc.add_child(dust)
