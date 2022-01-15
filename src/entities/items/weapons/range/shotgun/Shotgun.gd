extends "res://src/entities/items/weapons/range/rangeModule.gd"

onready var animation_player := $AnimationPlayer
onready var bullet_spawner := $BulletSpawner
onready var despawn_timer := $DespawnTimer

func _ready():
	setup_despawn()
