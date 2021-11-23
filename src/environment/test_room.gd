extends Node2D



func _ready():
	pass
#	var new_dialog = Dialogic.start('test')
#	add_child(new_dialog)

func _unhandled_input(event):
	if Input.is_action_just_pressed("action_1"):
		print("!")
		SceneChanger.change_scene("res://DeltaruneRippedSpriteTestBattleModeRoom.tscn", "fade")
