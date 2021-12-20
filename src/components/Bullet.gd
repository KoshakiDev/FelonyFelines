class_name Bullet
extends Node2D

const MAX_DISTANCE := 2000

# Internal state
var dir: Vector2 = Vector2.RIGHT
var speed: float = 1.0
var shooting: bool = false

onready var start_pos := global_position

var is_player_bullet = false

func _ready() -> void:
	shooting = true
	$ShootSound.play()

func setup(dir, speed) -> void:
	self.dir = dir
	self.speed = speed

func _physics_process(delta: float) -> void:
	if shooting:
		position += dir * speed * delta
		if start_pos.distance_to(global_position) > MAX_DISTANCE:
			queue_free()


func _on_Bullet_area_entered(area):
	print(area)
	queue_free()
