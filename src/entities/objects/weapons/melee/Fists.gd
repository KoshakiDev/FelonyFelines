extends "res://src/entities/objects/weapons/melee/meleeModule.gd"

export var weapon_name := "FISTS"

onready var hitbox := $AxeSprite/Hitbox
onready var animation_player := $AnimationPlayer

onready var attack_restart = $AttackRestart

var punch_points = 2

func action():
	if punch_points == 2:
		#print("Attack 1")
		animation_player.play("Attack1")
		attack_restart.start()
		punch_points -= 1
	elif punch_points == 1:
		#print("Attack 2")
		animation_player.play("Attack2")
		attack_restart.start()
		punch_points -= 1
#	elif punch_points == 1:
#		print("Attack 3")
#		animation_player.play("Attack3")
#		attack_restart.start()
#		punch_points -= 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack1":
		animation_player.play("Idle")
	elif anim_name == "Attack2":
		animation_player.play("Idle")
		punch_points = 2


func _on_AttackRestart_timeout():
	punch_points = 2
