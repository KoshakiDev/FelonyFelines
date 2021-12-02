extends KinematicBody2D 

var velocity: Vector2

var is_moving = false

export var max_health: float = 100
var health: float = max_health

export var player_id: String = "_1"

export var max_speed: int = 50
export var max_steering: float = 2.5
export var damage_value: float = 10

export var avoid_force: int = 50

export var arrival_zone_radius: int = 50

export var controlled: bool = false

func _input(event):
	if event.is_action_pressed("action_1"):
		$StatesMachine.transition_to("Attack")

func _ready():
	$Sprite.material.set_shader_param("is_control", false)

func find_targets_in_area(target_groups, area):
	var bodies = area.get_overlapping_bodies()
	var targets = []
	for body in bodies:
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
				break
	return targets

func stop_movement():
	is_moving = true

func continue_movement():
	is_moving = false

func return_travel_direction():
	var x_direction = stepify(velocity.x / max_speed, 1)
	var y_direction = stepify(velocity.y / max_speed, 1)
	return Vector2(x_direction, y_direction)
	
func insert_control_sd():
	controlled = true
	$Sprite.material.set_shader_param("is_control", controlled)

func extract_control_sd():
	controlled = false
	$Sprite.material.set_shader_param("is_control", controlled)

func play_animation(animation):
	$AnimTree.get("parameters/playback").travel(animation)

func adjust_blend_position(input_direction):
	$AnimTree.set("parameters/Idle/blend_position", input_direction)
	$AnimTree.set("parameters/Run/blend_position", input_direction)
