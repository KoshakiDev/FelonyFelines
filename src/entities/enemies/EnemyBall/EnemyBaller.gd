extends "res://src/entities/base_templates/base_npc/base_npc.gd"

export var cooldown_duration: float = 5

export var dash_duration: float = 3
export var dash_speed: int = 30

onready var hitbox = $Areas/Hitbox

func _ready():
	hitbox.init(self)

func _turn_on_hitbox():
	hitbox.monitorable = true
	hitbox.monitoring = true
	#hitbox_shape.set_deferred("disabled", false)

func _turn_off_hitbox():
	hitbox.monitorable = false
	hitbox.monitoring = false
	#hitbox_shape.set_deferred("disabled", true)

var dash_direction = Vector2.ZERO


func attack(target):
	dash_direction = (target.global_position - global_position).normalized() * dash_speed
	apply_dash(dash_direction)

func apply_dash(direction):
	movement.intended_velocity = direction * dash_speed

func search_for_target():
	return Global.get_farthest_player(global_position)
