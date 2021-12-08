extends Node2D


signal change_screen_face(type)
var current_face = "none"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show_none()
	connect("change_screen_face", self, "_on_change_screen_face")
	pass # Replace with function body.

func _on_change_screen_face(type):
	print("!!!")
	if type == "scissors":
		show_scissors()
	elif type == "paper":
		show_paper()
	elif type == "rock":
		show_rock()
	elif type == "none":
		show_none()

func show_scissors():
	$Paper.visible = false
	$Rock.visible = false
	$None.visible = false
	$Scissors.visible = true

func show_paper():
	$Paper.visible = true
	$Rock.visible = false
	$None.visible = false
	$Scissors.visible = false

func show_rock():
	$Paper.visible = false
	$Rock.visible = true
	$None.visible = false
	$Scissors.visible = false

func show_none():
	$Paper.visible = false
	$Rock.visible = false
	$None.visible = true
	$Scissors.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
