extends "res://src/entities/entityModules.gd"

export var player_id = "_1"

onready var state_machine := $StateMachine

onready var animation_machine := $AnimationMachine
onready var sprite := $Sprite

onready var weapon_manager := $Sprite/WeaponManager
onready var hand_position := $Sprite/WeaponManager/HandPosition2D

onready var health_bar := $HealthBar

var sprite_texture = preload("res://assets/entities/players/Sprite-0002-Sheet.png")
var axe_2_texture = preload("res://assets/entities/players/sooltan/axe_2.png")

func _ready():
	Global.set("sooltan", self)
	
	if player_id == "_2":
		sprite.set_texture(sprite_texture)
#		$WeaponManager/HandPosition2D/Axe.set_texture(axe_2_texture)
	pass

func _input(event):
	if event.is_action_pressed("next_weapon" + player_id):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon" + player_id):
		weapon_manager.switch_to_prev_weapon()
	if event.is_action_pressed("action" + player_id):
		 weapon_manager.cur_weapon.action()
