extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start('test')
	add_child(new_dialog)

func _unhandled_input(event):
	if Input.is_action_just_pressed("action_1"):
		print("!")
		SceneChanger.change_scene("res://src/environment/test/battlemode/BattleModeTest.tscn", "fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
