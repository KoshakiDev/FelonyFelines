extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var wave_survived = 0
var final_score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	setup()

func setup():
	wave_survived = Global.wave_survived
	final_score = Global.final_score
	if wave_survived == null:
		wave_survived = 0
	if final_score == null:
		final_score = 0
	$InfoPos/Info.bbcode_text = "[center]LAST WAVE: " + str(wave_survived) +"[/center]\n[center]LAST SCORE: " + str(final_score) + "[/center]" 
#
#func _input(event):
#	if event is InputEventKey:
#		if event.pressed:
#			back_to_menu()
#
#func back_to_menu():
#	SceneChanger.change_scene("res://src/menu/Menu.tscn", "fade")
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
