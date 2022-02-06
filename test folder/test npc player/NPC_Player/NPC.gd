extends "res://src/entities/entityModules.gd"

onready var state_machine := $StateMachine

onready var health_bar := $HealthBarPos/HealthBar

onready var animation_machine := $AnimationMachine

onready var sprite := $Sprite

onready var engage_range := $EngageRange
onready var hitbox = $Hitbox
onready var hurtbox = $Hurtbox

export var damage_value: float = 3
export var knockback_value: float = 125

onready var hand_position = $Sprite/WeaponManager/HandPosition2D

onready var hurtbox_collision = $Hurtbox/CollisionShape2D2
onready var weapon_manager = $Sprite/WeaponManager
onready var health_bar_position := $HealthBarPos
onready var movement_player = $AnimationMachine/Movement

func _ready():
	_initialize_health_bar(health_bar)
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	engage_range.connect("body_entered", self, "_on_EngageRange_body_entered")
	engage_range.connect("body_exited", self, "_on_EngageRange_body_exited")



func _turn_off_all():
	hurtbox_collision.disabled = true
	weapon_manager.visible = false
	health_bar_position.visible = false
	set_collision_layer_bit(1, false)

func _turn_on_all():
	hurtbox_collision.disabled = false
	weapon_manager.visible = true
	health_bar_position.visible = true
	set_collision_layer_bit(1, true)
