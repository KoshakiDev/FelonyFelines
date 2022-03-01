extends "res://src/entities/items/weapons/melee/meleeModule.gd"

onready var animation_player := $AnimationPlayer

onready var attack_restart = $AttackRestart

var punch_points = 2

func _ready():
	setup_despawn()
	
func action(_subject):
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
	elif punch_points == 0:
		animation_player.play("Attack3")
		damage_value = 10
		knockback_value = 25
		attack_restart.start()
	var direction = Vector2.RIGHT.rotated(global_rotation).normalized()
	print(_subject, " ", direction, " ", _subject.movement_direction)
	_subject.knockback += _subject.movement_direction * recoil

func _on_AnimationPlayer_animation_finished(anim_name):
	animation_player.play("Idle")
	if anim_name == "Attack3":
		punch_points = 2

func _on_AttackRestart_timeout():
	animation_player.play("Idle")
	damage_value = 5
	knockback_value = 1
	punch_points = 2
