extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$InfoAnimationPlayer.play("Idle")
	$CameraAnimationPlayer.play("Idle")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			SceneChanger.change_scene("res://src/environment/main.tscn", "fade")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
