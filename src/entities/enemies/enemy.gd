extends KinematicBody2D

const types = ["rock", "scissors", "paper"]


var velocity: Vector2
var type: String

export var controlled: bool = false

export var max_health: float = 100
var health: float = max_health

export var max_speed: int = 50
export var max_steering: float = 2.5
export var damage_value: float = 10


export var avoid_force: int = 1000

export var arrival_zone_radius: int = 50

onready var state_machine := $StatesMachine

onready var vision_area = $Area2D

onready var sprite = $Sprite

onready var health_bar = $HealthBar

onready var anim_player = $AnimationPlayer

onready var animation_tree = $AnimationTree

onready var raycasts = $Raycasts

onready var hit_range = $HitRange

onready var debug_label = $Label

var is_moving = false

func find_target(target_group):
	var bodies = vision_area.get_overlapping_bodies()
	var target = bodies
	for body in bodies:
		if body.is_in_group(target_group):
			target = body
			break
	return target

func stop_movement():
	is_moving = true

func continue_movement():
	is_moving = false

func in_range_hit(target_group):
	var bodies = hit_range.get_overlapping_bodies()
	var target = null
	for body in bodies:
		if body.is_in_group(target_group):
			target = body
			break
	return target

func _ready():
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
	

