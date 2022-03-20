extends Node

export var enable_splitscreen = true

export var current_world_path := NodePath()

onready var viewport1 = $Cameras/ViewportContainer/Viewport1

onready var cameras = $Cameras

func _ready():
	if current_world_path: 
		var current_world = get_node(current_world_path)
		#print(current_world, viewport1)
		#Global.reparent(current_world, viewport1)
		cameras.setup()
