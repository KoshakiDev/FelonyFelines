extends "res://src/entities/entityModules.gd"

export var player_id = "_1"

onready var state_machine := $StateMachine

onready var animation_machine := $AnimationMachine
onready var sprite := $Sprite

onready var weapon_manager := $WeaponManager
onready var hand_position := $WeaponManager/HandPosition2D
onready var dust_position := $DustPosition
onready var health_bar := $HealthBar

var DUST_SCENE = preload("res://src/effects/Dust.tscn")
var sprite_texture = preload("res://assets/entities/players/blue_brother_sheet_96x96.png")

export var is_stationary = false

func _ready():
	if player_id == "_2":
		Global.set("brother_2", self)
		$WeaponManager/HandPosition2D.position.y = 1
		sprite.set_texture(sprite_texture)
#		$WeaponManager/HandPosition2D/Axe.set_texture(axe_2_texture)
	else:
		Global.set("brother_1", self)
		Global.set("parent_location", get_parent())
	print(Global.parent_location)

func _input(event):
	if is_dead():
		return
	if event.is_action_pressed("next_weapon" + player_id):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon" + player_id):
		weapon_manager.switch_to_prev_weapon()
	if event.is_action_pressed("action" + player_id):
		 weapon_manager.cur_weapon.action()
	if event.is_action_pressed("reparent") and player_id == '_1':
		if !is_stationary:
			Global.reparent(self, Global.brother_2)
			is_stationary = true
		else:
			Global.reparent(self, Global.parent_location)
			is_stationary = false
			position = Global.brother_2.global_position

func spawn_dust() -> void:
	if is_stationary:
		return
	var dust: Sprite = DUST_SCENE.instance()
	#dust.set_as_toplevel(true)
	dust.position = dust_position.global_position
	
	#dust.global_position = Vector2(220, 220)
	get_parent().add_child_below_node(get_parent(), dust)


func _on_Hurtbox_area_entered(area):
	var areaParent = area.owner
	Shake.shake(4.0, .5)
	take_damage(areaParent)

func _physics_process(delta):
	if is_stationary:
		position = Vector2(0, -42)
