extends Node2D

onready var face_anim_player = $FaceAnimationPlayer
onready var head_anim_player = $HeadAnimationPlayer
onready var camera_anim_player = $CameraAnimationPlayer
onready var camera = $Camera2D
onready var info_text = $Head/Info
onready var spawners = $Arena/YSort/Spawners.get_children()
onready var face = $Head/Face


var wave_num = 0
var points = 0
var currently_controlled = "none"

var enemy_count = 0

func _ready():
	update_board()
	Global.set("main", self)
	head_anim_player.play("Idle")
	face_anim_player.play("Idle")
	
	update_wave()
	
func update_board():
	info_text.bbcode_text = "[center]WAVE: " + str(wave_num) + "[/center]\n[center]POINTS: " + str(points) + "[/center]\n[center]LEFT: " + str(enemy_count) + "[/center]"

func update_points(point_amount):
	points += point_amount
	update_board()

func update_wave():
	wave_num += 1
	
	for spawner in spawners:
		enemy_count += wave_num
		spawner.add_enemies(wave_num)

	update_board()

func update_currently_controlled(new_face):
	currently_controlled = new_face
	face.change_screen_face(currently_controlled)
