extends "res://src/entities/items/weapons/range/rangeModule.gd"

onready var animation_player := $Position2D/AnimationPlayer
onready var bullet_spawner = $Position2D/BulletSpawner
onready var despawn_timer := $Position2D/DespawnTimer

func _ready():
	setup_despawn()
