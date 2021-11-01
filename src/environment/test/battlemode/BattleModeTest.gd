extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_action_just_pressed("action_1"):
		SceneChanger.change_scene("res://src/environment/test/overworld/OverworldModeTest.tscn", "fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
