extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var area = $Area2D
onready var circle_progress_bar = $CircleProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "body_entered")	
	area.connect("body_exited", self, "body_exited")


func body_entered(body):
	circle_progress_bar.start()

func body_exited(body):
	circle_progress_bar.stop()
