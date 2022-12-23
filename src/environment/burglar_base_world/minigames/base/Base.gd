extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target = null

signal minigame_success

# Called when the node enters the scene tree for the first time.
func _ready():	
	if target == null:
		printerr("WARNING: No target was found!")
	target.interacting = true

func exit():
	target.interacting = false
	queue_free()
	
