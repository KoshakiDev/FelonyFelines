extends Node

export var enable_splitscreen = true

var current_world

onready var viewport1 = $Cameras/ViewportContainer/Viewport1

onready var cameras = $Cameras

func _ready():
	cameras.setup(enable_splitscreen)
	print(enable_splitscreen)
	#Global.reparent(current_world, viewport1)
