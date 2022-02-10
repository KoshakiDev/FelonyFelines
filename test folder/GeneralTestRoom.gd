extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var entity_world = $YSort


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set("entity_world", entity_world)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
