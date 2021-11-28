extends KinematicBody2D

const types = ["rock", "scissors", "paper"]


var velocity: Vector2
var type: String

export var controlled: bool = false

export var max_health: float = 100
export var health: float = max_health

export var max_speed: int = 50
export var max_steering: float = 2.5

onready var state_machine := $StatesMachine

onready var vision_area := $Area2D

onready var sprite := $Sprite

onready var health_bar := $HealthBar

onready var anim_player = $AnimationPlayer

onready var animation_tree = $AnimationTree


onready var debug_label = $Label

func find_target(target_group):
	var bodies = vision_area.get_overlapping_bodies()
	var target = owner
	for body in bodies:
		if body.is_in_group(target_group):
			target = body
	return target
	

func find_target_check(target_group):
	var bodies = vision_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group(target_group):
			return true
	return false


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
	
	pass

func play_animation(animation):
	animation_tree.get("parameters/playback").travel(animation)

func adjust_blend_position(input_direction):
	animation_tree.set("parameters/Idle/blend_position", input_direction)
	animation_tree.set("parameters/Run/blend_position", input_direction)

func _process(_delta: float) -> void:
	pass

func return_travel_direction():
	var x_direction = stepify(velocity.x / max_speed, 1)
	var y_direction = stepify(velocity.y / max_speed, 1)
	return Vector2(x_direction, y_direction)
