extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var face_anim_player = $FaceAnimationPlayer
onready var head_anim_player = $HeadAnimationPlayer
onready var camera = $Camera2D

onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	head_anim_player.play("Idle")
	face_anim_player.play("Idle")
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("action_2"):
		unzoom_camera()
		print("dd")

func unzoom_camera():
	tween.interpolate_property(camera, "zoom", Vector2(1, 1), Vector2(1.3333, 1.3333), 1)
	
func zoom_camera():
	camera.zoom.x = 1
	camera.zoom.y = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
