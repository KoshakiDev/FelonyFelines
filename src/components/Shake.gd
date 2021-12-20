extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var shake_intensity = 0.0
var shake_duration = 0.0

var camera: Camera2D

func _ready() -> void:
	for cam in get_tree().get_nodes_in_group("camera"):
		if cam.current:
			camera = cam

func _process(delta: float) -> void:
	if shake_duration <= 0.0:
		shake_duration = 0.0
		shake_intensity = 0.0
		return
	shake_duration -= delta
	if camera:
		var offset = Vector2(randf(), randf()) * shake_intensity
		camera.offset = offset

func set_camera(cam):
	camera = cam

func shake(intensity: float, duration: float):
	shake_intensity = intensity
	shake_duration = duration
