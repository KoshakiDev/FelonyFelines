extends Node2D

onready var face_anim_player = $FaceAnimationPlayer
onready var head_anim_player = $HeadAnimationPlayer
onready var camera_anim_player = $CameraAnimationPlayer
onready var camera = $Camera2D
onready var info_text = $Head/Info

onready var face = $Head/Face


var wave_num = 0
var points = 0
var currently_controlled = "none"

func _ready():
	update_board()
	Global.set("main", self)
	head_anim_player.play("Idle")
	face_anim_player.play("Idle")
	
func update_board():
	info_text.bbcode_text = "[center]WAVE: " + str(wave_num) + "[/center]\n[center]POINTS: " + str(points) + "[/center]"

func update_points(point_amount):
	print("I was launched once!")
	points += point_amount
	update_board()

func update_wave():
	wave_num += 1
	update_board()

func update_currently_controlled(new_face):
	currently_controlled = new_face
	face.change_screen_face(currently_controlled)
