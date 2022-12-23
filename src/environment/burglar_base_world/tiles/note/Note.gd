extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var text = ""
onready var interaction_zone = $InteractionZone


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_zone.connect("window_created", self, "set_text")

func set_text():
	interaction_zone.window.set_text(text)
	
