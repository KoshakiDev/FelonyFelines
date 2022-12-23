extends "res://src/environment/burglar_base_world/minigames/base/Base.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("up_2"):
		emit_signal("minigame_success")
		exit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
