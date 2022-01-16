extends "res://src/entities/items/weapons/melee/meleeModule.gd"

onready var animation_player := $AnimationPlayer
onready var despawn_timer := $DespawnTimer

func _ready():
	setup_despawn()
