extends "res://src/entities/entityModules.gd"

export var player_id = "_1"

onready var state_machine := $StateMachine

onready var animation_machine := $AnimationMachine
onready var movement_player := $AnimationMachine/Movement
onready var sprite := $Sprite

onready var weapon_manager := $Sprite/WeaponManager
onready var hand_position := $Sprite/WeaponManager/HandPosition2D
onready var dust_position := $DustPosition
onready var health_bar := $HealthBarPos/HealthBar
onready var health_bar_position := $HealthBarPos

var DUST_SCENE = preload("res://src/components/effects/Dust.tscn")
var sprite_texture = preload("res://assets/entities/players/blue_brother_sheet_96x96.png")
onready var shadow = $Shadow

onready var respawn_radius = $RespawnRadius
onready var respawn_timer = $RespawnRadius/Timer
onready var timer_label = $RespawnRadius/TimerLabel

onready var hurtbox_collision = $Hurtbox/CollisionShape2D2
onready var hurtbox = $Hurtbox
onready var collision = $Collider

onready var tween = $Tween

onready var run_timer = $RunTimer
var fast_run = true
onready var max_speed_memory = max_speed
onready var slow_max_speed = max_speed - 200


func _ready():
	respawn_radius.visible = true
	_initialize_health_bar(health_bar)
	set_health(health)
	if player_id == "_2":
		health_bar_position.position.y -= 11
		hand_position.position.y -= 11
		sprite.set_texture(sprite_texture)
	Global.set("brother" + player_id, self)
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")

func _input(event):
	if is_dead():
		return
	if event.is_action_pressed("next_weapon" + player_id):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon" + player_id):
		weapon_manager.switch_to_prev_weapon()
	if event.is_action_pressed("action" + player_id):
		weapon_manager.cur_weapon.action(self)
		disable_fast_run()

func spawn_dust() -> void:
	var dust: Sprite = DUST_SCENE.instance()
	dust.position = dust_position.global_position

	get_parent().add_child_below_node(get_parent(), dust)

# func frame_freeze(time_scale, duration):
# 	Engine.time_scale = time_scale
# 	yield(get_tree().create_timer(duration * time_scale), "timeout")
# 	Engine.time_scale = 1.0

func _physics_process(delta):
	if respawn_timer.time_left != 0:
		timer_label.bbcode_text = "[center]RESPAWNING IN:[/center]\n" + "[center][color=#ff0000]" + str(respawn_timer.time_left) + "[/color][/center]" 
	else:
		timer_label.set_text("")

func respawn_player():
	heal(max_health)
	_turn_on_all()
	state_machine.transition_to("Idle")


func _on_RespawnRadius_body_entered(body):
	if !body.get("player_id"):
		return
	if player_id == body.player_id or not is_dead(): return
	respawn_timer.start(5)
	
func _on_Timer_timeout():
	play_animation("Respawn", "Movement")

func _on_RespawnRadius_body_exited(body):
	respawn_timer.stop()


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


func _on_PickupArea_area_entered(area):	
	if not area.is_in_group("ITEM"):
		return
	
	var item = area.owner
	
	if item.item_type == "WEAPON":
		if item.in_inventory: return

		var weapons_container = hand_position
		
		item.in_inventory = true
		item.despawnable = false
	
		item.position = Vector2.ZERO
		
		Global.reparent(item, weapons_container)
		weapon_manager.update_children()
	else:
		item._action(self)

func disable_fast_run():
	if is_dead():
		return
#	if state_machine.state.name == "Idle":
#		animation_machine.play_animation("Knockback", "Movement")
	if !run_timer.is_stopped():
		return
	fast_run = false
	max_speed = slow_max_speed
	if state_machine.state.name == "Move":
		state_machine.transition_to("Move")
	run_timer.start()

func enable_fast_run():
	if is_dead():
		return
	fast_run = true
	max_speed = max_speed_memory
	if state_machine.state.name == "Move":
		state_machine.transition_to("Move")

func _on_RunTimer_timeout():
	enable_fast_run()
