extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var shake_intensity = 0.0
var shake_duration = 0.0

var camera1: Camera2D
var camera2: Camera2D

func _ready() -> void:
	for cam in get_tree().get_nodes_in_group("camera"):
		if cam.current:
			if camera1 != null:
				camera1 = cam
			elif camera2 != null:
				camera2 = cam

func _process(delta: float) -> void:
	if shake_duration <= 0.0:
		shake_duration = 0.0
		shake_intensity = 0.0
		return
	shake_duration -= delta
	if camera1 or camera2:
		var offset = Vector2(randf(), randf()) * shake_intensity
		camera1.offset = offset
		camera2.offset = offset

func set_camera(cam1, cam2):
	camera1 = cam1
	camera2 = cam2

func shake(intensity: float, duration: float):
	shake_intensity = intensity
	shake_duration = duration
