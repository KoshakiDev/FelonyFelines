extends "res://src/entities/items/weapons/range/rangeModule.gd"

onready var animation_player := $Position2D/AnimationPlayer
onready var bullet_spawner = $Position2D/BulletSpawner
onready var despawn_timer := $Position2D/DespawnTimer


func _ready():
	setup_despawn()
	#deplete_ammo()
	max_ammo = setup_max_ammo(bullet_spawner.shot_delay, animation_player.get_animation("Shoot").length, bullet_spawner.bullet_emitter)
