#extends "res://src/entities/entityModules.gd"
extends "res://src/entities/players/player/player.gd"

#onready var state_machine := $StateMachine

#onready var health_bar := $HealthBarPos/HealthBar
#
#onready var animation_machine := $AnimationMachine
#
#onready var sprite := $Sprite
#
#var DUST_SCENE = preload("res://src/components/effects/Dust.tscn")
#
#
onready var engage_range := $EngageRange
#onready var hurtbox = $Hurtbox
#
#export var damage_value: float = 3
#export var knockback_value: float = 125
#
#onready var hand_position = $Sprite/WeaponManager/HandPosition2D
#
#onready var hurtbox_collision = $Hurtbox/CollisionShape2D2
#onready var weapon_manager = $Sprite/WeaponManager
#onready var health_bar_position := $HealthBarPos
#onready var movement_player = $AnimationMachine/Movement
#
#onready var respawn_radius = $RespawnRadius
#onready var respawn_timer = $RespawnRadius/Timer
#onready var timer_label = $RespawnRadius/TimerLabel
#
#onready var dust_position := $DustPosition
#
#
#onready var tween = $Tween
#
#onready var run_timer = $RunTimer
#var fast_run = true
#onready var max_speed_memory = max_speed
#onready var slow_max_speed = max_speed - 200
#
#export var player_id = "_1"

func switch_to_next_weapon():
	weapon_manager.switch_to_next_weapon()

func switch_to_prev_weapon():
	weapon_manager.switch_to_prev_weapon()


#this is the attack function for weapons
func action():
	weapon_manager.cur_weapon.action(self)
	disable_fast_run()	

func _input(event):
	pass

func _ready():
	_initialize_health_bar(health_bar)
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	engage_range.connect("body_entered", self, "_on_EngageRange_enemy_entered")
	engage_range.connect("body_exited", self, "_on_EngageRange_enemy_exited")
	respawn_radius.connect("body_entered", self, "_on_RespawnRadius_body_entered")
	respawn_radius.connect("body_exited", self, "_on_RespawnRadius_body_exited")
	respawn_timer.connect("timeout", self, "_on_Timer_timeout")
	run_timer.connect("timeout", self, "_on_RunTimer_timeout")
	pickup_area.connect("area_entered", self, "_on_PickupArea_area_entered")
