extends "res://src/entities/items/itemModules.gd"

# Don't forget to rename it as it was, "Medkit"

export var heal_value = 20

onready var anim_player := $AnimationPlayer
onready var despawn_timer := $DespawnTimer
onready var area := $Area2D

func _ready():
	anim_player.play("idle")
	setup_despawn()

func _action(target):
	$AnimationPlayer.play("pickup")
	yield($AnimationPlayer, "animation_finished")
	
	target.heal(heal_value)
	
	queue_free()
