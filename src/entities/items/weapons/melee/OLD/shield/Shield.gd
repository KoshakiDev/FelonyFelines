extends "res://src/entities/items/weapons/melee/meleeModule.gd"

onready var animation_player := $AnimationPlayer
onready var despawn_timer := $DespawnTimer

onready var area = $Area2D/CollisionShape2D
onready var static_body = $StaticBody2D/CollisionShape2D

func _ready():
	setup_despawn()

func set_inactive():
	area.disabled = true
	static_body.disabled = true
	visible = false

func set_active():
	area.disabled = false
	static_body.disabled = false
	visible = true
