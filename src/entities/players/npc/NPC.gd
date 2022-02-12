extends "res://src/entities/players/player/player.gd"

onready var engage_range := $EngageRange

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

func switch_to_next_weapon():
	weapon_manager.switch_to_next_weapon()

func switch_to_prev_weapon():
	weapon_manager.switch_to_prev_weapon()

#this is the attack function for weapons
func action():
	weapon_manager.cur_weapon.action(self)
	disable_fast_run()

