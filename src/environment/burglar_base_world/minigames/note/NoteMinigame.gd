extends "res://src/environment/burglar_base_world/minigames/base/Base.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var text = $Text

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_just_pressed("left_2") || Input.is_action_just_pressed("right_2") || Input.is_action_just_pressed("up_2") || Input.is_action_just_pressed("down_2"):
		exit()

func set_text(new_text: String):
	text.text = new_text
