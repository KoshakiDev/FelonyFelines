extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var progress_sprite = $ProgressSprite
onready var timer = $Timer

export var time = 2.5

func _ready():
	setup_timer()

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	progress_sprite.material.set_shader_param("progress", 1.0 - timer.time_left / time)

func setup_timer():
	timer.wait_time = time
	timer.one_shot = true
	timer.autostart = false

func start():
	timer.start()

func stop():
	timer.stop()
