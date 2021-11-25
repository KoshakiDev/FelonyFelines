extends KinematicBody2D


var velocity: Vector2

export var max_health: int = 100

export var max_speed: int = 50
export var max_steering: float = 2.5

onready var state_machine := $StatesMachine

onready var vision_area := $Area2D

onready var health_bar := $HealthBar

func _ready():
	#ready_card()
	pass

func play_animation(animation):
	pass
	#animation_tree.get("parameters/playback").travel(animation)

func adjust_blend_position(input_direction):
	pass
	#animation_tree.set("parameters/Idle/blend_position", input_direction)
	#animation_tree.set("parameters/Run/blend_position", input_direction)

func _process(_delta: float) -> void:
	pass
