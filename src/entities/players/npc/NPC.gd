extends "res://src/entities/players/player/player.gd"

onready var engage_range := $EngageRange

var cooldown_passed = true

func _physics_process(delta):
	#print(movement_direction)
	print(state_machine.state)

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

func there_is_an_enemy_in_distance(distance):
	var closest_enemy_position = Global.get_closest_enemy(owner.global_position)
	var path = Global.navigation.get_simple_path(owner.global_position, closest_enemy_position, false)
	var path_length = 0
	print("closest enemy ", closest_enemy_position)
	if path.size() > 0:
		for i in range(path.size() - 1):
			#print(path[i], " ", path[i-1], " ", (path[i] - path[i-1]).length())
			path_length += (path[i] - path[i-1]).length()
	print(path_length, " ", distance)
	if path_length < distance:
		return true
	else:
		return false

func there_is_an_enemy_in_attack_angle():
	var closest_enemy_position = Global.get_closest_enemy(owner.global_position)
	var angle_rad = (owner.global_position - closest_enemy_position).angle()
	var angle_deg = int(abs(angle_rad * (180/PI)))
	#print(angle_deg % 45, " ", angle_deg)
	return angle_deg % 45 <= 3

func is_there_item(target_item):
	#the target item name must match the existing item types 
	for item in Global.items.get_children():
		if item.item_type == target_item:
			return true
	return false

func return_item_position(target_item):
	#the target item name must match the existing item types 
	var target_item_position = Vector2.ZERO
	#print(Global.items.get_children())
	for item in Global.items.get_children():
		if item.item_type == target_item:
			target_item_position = item.global_position
	return target_item_position
