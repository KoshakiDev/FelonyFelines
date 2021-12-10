extends Node2D



func _ready():
	show_none()

func change_screen_face(type):
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
