extends "res://src/entities/base_templates/base_entity/base_entity.gd"

onready var attack_range = $Areas/AttackRange
onready var nav_manager = $Functions/NavigationManager


# Non-Player Variables
export var ITEM_DROP_PERCENT = 50
var current_bodies_in_attack_range = []

##SOUNDS:
onready var attack_sound = $SoundMachine/Attack


func _ready():
	attack_range.connect("body_entered", self, "_on_AttackRange_body_entered")
	attack_range.connect("body_exited", self, "_on_AttackRange_body_exited")	

func _on_AttackRange_body_entered(body):
	if entity_type == "ENEMY":
		_enemy_check_for_entered_player(body)
	if entity_type == "PLAYER_NPC":
		_player_check_for_entered_enemy(body)

func _on_AttackRange_body_exited(body):
	if entity_type == "ENEMY":
		_enemy_check_for_exited_player(body)
	if entity_type == "PLAYER_NPC":
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

var hit_pos

func is_target_in_aim(target):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.hurtbox_shape.shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(position,
				pos, [self], collision_mask)
		#print(result)
		if result:
			hit_pos.append(result.position)
			if !result.collider.get("entity_type"):
				break
			if result.collider.is_in_group("PLAYER"):
				return true
			if result.collider.is_in_group("ENEMY") and entity_type == "PLAYER_NPC":
				return true
	return false

func aim(target):
	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.hurtbox_shape.shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(global_position,
				pos, [self], collision_mask)
		#print(result)
		if result:
			hit_pos.append(result.position)
			if !result.collider.get("entity_type"):
				break
			if result.collider.is_in_group("PLAYER"):
				attack(target)
				break
			if result.collider.is_in_group("ENEMY") and entity_type == "PLAYER_NPC":
				attack(target)
				break

func attack(target):
	pass
