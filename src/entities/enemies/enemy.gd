extends KinematicBody2D

const types = ["rock", "scissors", "paper"]


var velocity: Vector2
var type: String

var controlled: bool = false

export var max_health: float = 100
export var health: float = max_health

export var max_speed: int = 50
export var max_steering: float = 2.5

onready var state_machine := $StatesMachine

onready var vision_area := $Area2D

onready var sprite := $Sprite

onready var health_bar := $HealthBar

func take_damage(damage_value):
	health = health - damage_value
	if health < 0:
		print("dead")
		return
	print(health)
	health_bar.set_percent_value(health / max_health * 100)
	return
	
func _ready():
	#ready_card()
	randomize()
	type = types[randi() % types.size()]

	var path = "res://assets/entities/enemies/{type}.png".format({"type": type})
	print(path)
	sprite.texture = load(path)
	sprite.scale = Vector2(0.25, 0.25)
	
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
