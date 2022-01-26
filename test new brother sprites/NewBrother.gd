extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim_player = $AnimationPlayer
onready var anim_player2 = $AnimationPlayer2

var carrying_shotgun = false
onready var shotgun = $Sprite/Shotgun
onready var shotgun2 = $Sprite2/Shotgun
onready var sprite = $Sprite
onready var sprite2 = $Sprite2

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("idle")
	anim_player2.play("idle")

func _input(event):
	if event.is_action_pressed("next_weapon_1") or event.is_action_pressed("prev_weapon_1"):
		if carrying_shotgun:
			carrying_shotgun = false
		else:
			carrying_shotgun = true
		#shotgun.visible = carrying_shotgun
		#shotgun2.visible = carrying_shotgun
	if event.is_action_pressed("left_1") or event.is_action_pressed("right_1"):
		if event.is_action_pressed("left_1"):
			sprite.scale.x = -1
			sprite2.scale.x = -1
		if event.is_action_pressed("right_1"):
			sprite.scale.x = 1
			sprite2.scale.x = 1
		anim_player.play("accelerate")
		anim_player2.play("accelerate")
		
	if event.is_action_released("left_1") or event.is_action_released("right_1"):
		decelerate()

func play_idle():
	anim_player.play("idle")
	anim_player2.play("idle")
	

func accelerate():
	if carrying_shotgun:
		anim_player.play("run_slow")
		anim_player2.play("run_slow")
	else:
		anim_player.play("run_fast")
		anim_player2.play("run_fast")

func decelerate():
	if carrying_shotgun:
		anim_player.play("small_decelerate")
		anim_player2.play("small_decelerate")
	else:
		anim_player.play("big_decelerate")
		anim_player2.play("big_decelerate") 

func play_run_slow():
	anim_player.play("run_slow")
	anim_player2.play("run_slow")

func play_run_fast():
	anim_player.play("run_fast")
	anim_player2.play("run_fast")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
