extends "res://src/entities/base_templates/base_entity/base_entity.gd"

export var player_id = "_1"
var red_sprite = preload("res://assets/entities/players/red_brother_sheet_96x96.png")
var blue_sprite = preload("res://assets/entities/players/blue_brother_sheet_96x96.png")

onready var weapon_manager := $Visuals/Sprite/WeaponManager
onready var dust_spawner = $Visuals/DustSpawner

onready var item_pickup = $Areas/ItemPickup
onready var respawn_radius = $Areas/Respawn

onready var shadow = $Shadow

onready var tween = $Tween

onready var ammo_bar = $AmmoBar

var is_resistance = false

func _ready():
	setup_player()

func setup_player():
	if player_id == "_1":
		$HealthBar.position.y = -85 + 10
		weapon_manager.position.y = 30
		sprite.set_texture(red_sprite)
	elif player_id == "_2":
		$HealthBar.position.y = -85
		weapon_manager.position.y = 16
		sprite.set_texture(blue_sprite)
	Global.set("brother" + player_id, self)

func _input(event):
	if health_manager.is_dead():
		return
	if event.is_action_pressed("next_weapon" + player_id):
		weapon_manager.switch_to_next_weapon()
		ammo_bar.update_ammo_bar(weapon_manager.return_ammo_count())
	if event.is_action_pressed("prev_weapon" + player_id):
		weapon_manager.switch_to_prev_weapon()
		ammo_bar.update_ammo_bar(weapon_manager.return_ammo_count())
	if event.is_action_pressed("action" + player_id):
		weapon_manager.update_children()
		if weapon_manager.cur_weapon != null:
			if weapon_manager.cur_weapon.entity_name == "MEDKIT" or weapon_manager.cur_weapon.entity_name == "AMMO":
				weapon_manager.cur_weapon.action(self)
				weapon_manager.update_children()
				weapon_manager.switch_to_next_weapon()
			else:
				weapon_manager.cur_weapon.action(self)
				ammo_bar.update_ammo_bar(weapon_manager.return_ammo_count())

func _on_Hurtbox_area_entered(area):
	if health_manager.is_dead(): return
	._on_Hurtbox_area_entered(area)
	Shake.shake(4.0, .5)
	var attacker = area.owner
	var attack_direction
	if area.is_in_group("PROJECTILE"):
		attacker = area
		attack_direction = attacker.dir
	else:
		attack_direction = attacker.intended_velocity
	
	if (attack_direction.x > 0 and sprite.scale.x == 1) or (attack_direction.x < 0 and sprite.scale.x == -1):
		state_machine.transition_to("Pain", {Back = true})
	elif (attack_direction.x > 0 and sprite.scale.x == -1) or (attack_direction.x < 0 and sprite.scale.x == 1):
		state_machine.transition_to("Pain", {Front = true})
	
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
