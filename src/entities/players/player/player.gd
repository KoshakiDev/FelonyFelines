extends "res://src/entities/base_templates/base_entity/base_entity.gd"

export var player_id = "_1"
const red_sprite = preload("res://assets/entities/players/red_brother_sheet_96x96.png")
const blue_sprite = preload("res://assets/entities/players/blue_brother_sheet_96x96.png")

onready var weapon_manager := $Visuals/Sprite/WeaponManager
onready var dust_spawner = $Visuals/DustSpawner

onready var item_pickup = $Areas/ItemPickup
onready var respawn_radius = $Areas/Respawn

onready var ammo_bar = $AmmoBar

var player_visual_middle = Vector2(0, -50)

var is_resistance = false

signal player_died
signal hidden
signal unhidden
##sounds
onready var pickup_sound = $SoundMachine/Pickup

var is_in_shadow = false
var is_hidden = false setget set_hidden


func set_hidden(new_value):
	is_hidden = new_value
	if is_hidden:
		emit_signal("hidden")
	else:
		emit_signal("unhidden")

var interacting = false

func hide():
	animation_machine.play_animation("Hidden", "Hidden")


func unhide():
	animation_machine.play_animation("Unhidden", "Hidden")


func _ready():
	setup_player()
	self.connect("hidden", self, "hide")
	self.connect("unhidden", self, "unhide")
	weapon_manager.init(self, ammo_bar)

func setup_player():
	if player_id == "_1":
		$HealthBar.position.y = -85 + 10
		weapon_manager.position.y = 30
		sprite.set_texture(red_sprite)
		player_visual_middle = Vector2(0, -50 + 10)
		listener.current = true;
	
	elif player_id == "_2":
		$HealthBar.position.y = -85
		weapon_manager.position.y = 16
		sprite.set_texture(blue_sprite)
		player_visual_middle = Vector2(0, -50)
	#Global.set("brother" + player_id, self)
	#connect("player_died", Global, "player_died")


func adjust_weapon_rotation(direction):
	weapon_manager.look_at(weapon_manager.global_position + direction)

func _physics_process(delta):
	adjust_weapon_rotation(movement.vector_to_movement_direction(movement.get_intended_velocity()))



func _input(event):

	if health_manager.is_dead():
		return
	if interacting:
		return
	if weapon_manager.cur_weapon == null:
		return
	if event.is_action_pressed("next_weapon" + player_id):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon" + player_id):
		weapon_manager.switch_to_prev_weapon()
		
	if event.is_action_pressed("action" + player_id):
		weapon_manager.cur_weapon.action()
		if weapon_manager.return_ammo_count() <= 0 and weapon_manager.cur_weapon.item_type != "MELEE":
			weapon_manager.switch_to_next_weapon()
	
	elif event.is_action_released("action" + player_id):
		if weapon_manager.cur_weapon.item_type == "RANGE":
			weapon_manager.cur_weapon.stop_shooting()

func hurt(attacker_area):
	.hurt(attacker_area)
	Shake.shake(4.0, .5)
	
	
# func frame_freeze(time_scale, duration):
# 	Engine.time_scale = time_scale
# 	yield(get_tree().create_timer(duration * time_scale), "timeout")
# 	Engine.time_scale = 1.0

func respawn_player():
	play_animation("Respawn", "Movement")
	yield(get_animation_player("Movement"), "animation_finished")
	health_manager.heal(health_manager.max_health / 10)
	_turn_on_all()
	state_machine.transition_to("Idle")


func _turn_off_all():
	ammo_bar.visible = false
	if weapon_manager.cur_weapon != null:
		if weapon_manager.cur_weapon.item_type == "RANGE":
			weapon_manager.cur_weapon.stop_shooting()
	can_get_hit = false
	hurtbox.monitoring = false
	hurtbox.monitorable = false
	weapon_manager.visible = false
	health_bar.visible = false
	respawn_radius.activate_respawn_radius()
	set_collision_layer_bit(1, false)
	emit_signal("player_died")

func _turn_on_all():
	ammo_bar.visible = true
	can_get_hit = true
	hurtbox.monitoring = true
	hurtbox.monitorable = true
	weapon_manager.visible = true
	health_bar.visible = true
	respawn_radius.deactivate_respawn_radius()
	set_collision_layer_bit(1, true)
	ammo_bar.update_ammo_bar(weapon_manager.return_ammo_count())
