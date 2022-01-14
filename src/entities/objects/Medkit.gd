extends Position2D

export var type = "Medkit"

export var heal_value = 20

onready var anim_player = $AnimationPlayer

onready var area = $Area2D

func _ready():
	anim_player.play("idle")

func _action(target):
	$AnimationPlayer.play("pickup")
	yield($AnimationPlayer, "animation_finished")
	
	target.heal(heal_value)
	
	queue_free()
