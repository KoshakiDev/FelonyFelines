extends "res://src/entities/base_templates/base_npc/base_npc.gd"

export var cooldown_duration: float = 5

export var dash_duration: float = 3
export var dash_speed: int = 30

onready var hitbox = $Areas/Hitbox
onready var hitbox_shape = $Areas/Hitbox/HitboxShape

#SOUNDS
func _ready():
	turn_off_hitbox()

func turn_on_hitbox():
	hitbox.monitorable = true
	hitbox.monitoring = true
	#hitbox_shape.set_deferred("disabled", false)

func turn_off_hitbox():
	hitbox.monitorable = false
	hitbox.monitoring = false

func attack(target):
	pass
	
func search_for_target():
	return Global.get_farthest_player(global_position)

	
