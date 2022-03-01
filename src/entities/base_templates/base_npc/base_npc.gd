extends "res://src/entities/base_templates/base_entity/base_entity.gd"

onready var attack_range = $Areas/AttackRange
onready var nav_manager = $Functions/NavigationManager


# Non-Player Variables
export var ITEM_DROP_PERCENT = 50
var current_bodies_in_attack_range = []


func _ready():
	attack_range.connect("body_entered", self, "_on_AttackRange_body_entered")
	attack_range.connect("body_exited", self, "_on_AttackRange_body_exited")	

func _on_AttackRange_body_entered(body):
	if entity_type == "ENEMY":
		_enemy_check_for_entered_player(body)
	if entity_type == "PLAYER_2":
		_player_check_for_entered_enemy(body)

func _on_AttackRange_body_exited(body):
	if entity_type == "ENEMY":
		_enemy_check_for_exited_player(body)
	if entity_type == "PLAYER_2":
		_player_check_for_exited_enemy(body)

#ENEMY CHECKER
func _enemy_check_for_entered_player(body):
	if not body.is_in_group("PLAYER"): 
		return
	if body.health_manager.is_dead():
		return
	current_bodies_in_attack_range.append(body)
	
func _enemy_check_for_exited_player(body):
	if not body.is_in_group("PLAYER"): 
		return
	current_bodies_in_attack_range.erase(body)

#PLAYER CHECKER
func _player_check_for_entered_enemy(body):
	if not body.is_in_group("ENEMY"):
		return
	current_bodies_in_attack_range.append(body)

func _player_check_for_exited_enemy(body):
	if not body.is_in_group("ENEMY"):
		return
	current_bodies_in_attack_range.erase(body)
