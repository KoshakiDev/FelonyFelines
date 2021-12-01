extends Node2D



func _ready():
	pass
#	var new_dialog = Dialogic.start('test')
#	add_child(new_dialog)

func _unhandled_input(event):
	pass

func _physics_process(delta):
	print(Engine.get_frames_per_second()) 
