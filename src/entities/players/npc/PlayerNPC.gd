extends "res://src/entities/base_templates/base_npc/base_npc.gd"

export var player_id = "_1"
var red_sprite = preload("res://assets/entities/players/red_brother_sheet_96x96.png")
var blue_sprite = preload("res://assets/entities/players/blue_brother_sheet_96x96.png")

onready var weapon_manager := $Visuals/Sprite/WeaponManager
onready var dust_spawner = $Visuals/DustSpawner

onready var item_pickup = $Areas/ItemPickup
onready var respawn_radius = $Areas/Respawn

onready var shadow = $Shadow

onready var tween = $Tween

onready var run_timer = $RunTimer

var is_resistance = false

func attack(target):
	var look_dir = (target.global_position - global_position).normalized()
	if look_dir.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	if sprite.scale.x == -1:
		weapon_manager.rotation = PI - (target.global_position - global_position).angle()
	elif sprite.scale.x == 1:
		weapon_manager.rotation = (target.global_position - global_position).angle()
	weapon_manager.cur_weapon.action(self)
	enable_resistance()


func _ready():
	setup_player()

func setup_player():
	if player_id == "_1":
		$HealthBar.position.y = -64
		weapon_manager.position.y = 30
		sprite.set_texture(red_sprite)
	elif player_id == "_2":
		$HealthBar.position.y = -64 - 11
		weapon_manager.position.y = 20
		sprite.set_texture(blue_sprite)
	Global.set("brother" + player_id, self)

#func _input(event):
##	if health_manager.is_dead():
##		return
##	if event.is_action_pressed("next_weapon" + player_id):
##		weapon_manager.switch_to_next_weapon()
##	if event.is_action_pressed("prev_weapon" + player_id):
##		weapon_manager.switch_to_prev_weapon()

func _on_Hurtbox_area_entered(area):
	._on_Hurtbox_area_entered(area)
	Shake.shake(4.0, .5)
	enable_resistance()

# func frame_freeze(time_scale, duration):
# 	Engine.time_scale = time_scale
# 	yield(get_tree().create_timer(duration * time_scale), "timeout")
# 	Engine.time_scale = 1.0

func respawn_player():
	play_animation("Respawn", "Movement")
	yield(get_animation_player("Movement"), "animation_finished")
	health_manager.heal(health_manager.max_health)
	_turn_on_all()
	state_machine.transition_to("Idle")
	

func _turn_off_all():
	can_get_hit = false
	hurtbox.monitoring = false
	hurtbox.monitorable = false
	weapon_manager.visible = false
	healthbar.visible = false
	set_collision_layer_bit(1, false)

func _turn_on_all():
	can_get_hit = true
	hurtbox.monitoring = true
	hurtbox.monitorable = true
	weapon_manager.visible = true
	healthbar.visible = true
	set_collision_layer_bit(1, true)

func enable_resistance():
	if is_extra_resistance_on:
		return
	is_extra_resistance_on = true
	if state_machine.state.name == "Move":
		state_machine.transition_to("Move")
	run_timer.start()

func disable_resistance():
	is_extra_resistance_on = false
	if state_machine.state.name == "Move":
		state_machine.transition_to("Move")

func _on_RunTimer_timeout():
	disable_resistance()
