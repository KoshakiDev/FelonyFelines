extends Node

onready var FRICTION = 0.1

var brother_1
var brother_2

var entity_world
var main
var items
var root 

var final_score
var wave_survived

var ITEM_DROP_WEIGHTS = {
	"weapons/melee/axe/Axe": 3,
	"weapons/melee/spear/Spear": 3,
	"weapons/range/assault rifle/AssaultRifle": 2,
	"weapons/range/shotgun/Shotgun": 2,
	"medkit/Medkit": 5,
	"weapons/range/minigun/Minigun": 1,
	"weapons/range/revolver/Revolver": 3
}

func _ready():
	root = get_parent()
	normalize_item_drop_weights()
	
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)

func get_all_enemies():
	var enemies = {
		"BALL":[],
		"GUNNER":[],
		"IMP":[]
	}
	
	var enemy_types = enemies.keys()
	
	for entity in entity_world.get_children():
		if not entity.is_in_group("ENTITY"):
			continue

		if entity.entity_type in enemy_types:
			enemies[entity.entity_type].append(entity)

	return enemies

func get_all_enemies_list():
	var enemies = []
	var enemy_names = ["BALL", "GUNNER", "IMP"]
	
	for entity in entity_world.get_children():
		if not entity.is_in_group("ENTITY"):
			continue

		if entity.entity_name in enemy_names:
			enemies.append(entity)
	
	return enemies


func normalize_item_drop_weights():
	var sum = 0
	# force multiplier to be a float
	var multiplier = 1.0
	for key in ITEM_DROP_WEIGHTS:
		sum += round(ITEM_DROP_WEIGHTS[key])
	# if our sum is greater than 100 then we want then find the
	# multiplier that will bring it close to 100
	if sum > 100:
		multiplier = 100/sum

	for key in ITEM_DROP_WEIGHTS:
		# First do the multiplier
		ITEM_DROP_WEIGHTS[key] = multiplier * float(ITEM_DROP_WEIGHTS[key])
		# if rounding it will make it zero (i.e. it was .4) then make it 1
		if ITEM_DROP_WEIGHTS[key] > 0 && round(ITEM_DROP_WEIGHTS[key]) == 0:
			ITEM_DROP_WEIGHTS[key] = 1
		else:
			ITEM_DROP_WEIGHTS[key] = round(ITEM_DROP_WEIGHTS[key])


func get_closest_enemy(position: Vector2):
	var closest_enemy: Vector2 = Vector2.ZERO
	var closest_distance = 999999999
	
	for enemy in get_all_enemies_list():
		var distance = (position - enemy.global_position).length()
		if distance < closest_distance:
			closest_enemy = enemy.global_position
			closest_distance = distance
	
	return closest_enemy


func get_closest_player(position: Vector2):
	var closest_player: Vector2 = Vector2.ZERO
	var closest_distance = 999999999
	
	for player in entity_world.get_children():
		if not player.is_in_group("PLAYER"): continue
		if player.is_dead(): continue
		
		var distance = (position - player.global_position).length()
		if distance < closest_distance:
			closest_player = player.global_position
			closest_distance = distance
	
	return closest_player

func get_farthest_player(position: Vector2):
	var farthest_player: Vector2 = Vector2.ZERO
	var farthest_distance = 0

	for player in entity_world.get_children():
		if not player.is_in_group("PLAYER"): continue
		if player.is_dead(): continue
		
		var distance = (position - player.global_position).length()
		if distance > farthest_distance:
			farthest_player = player.global_position
			farthest_distance = distance
	
	return farthest_player	

func get_lowest_hp_player():
	var lowest_hp_player: Vector2 = Vector2.ZERO
	var lowest_hp = 999999999
	
	for player in entity_world.get_children():
		if not player.is_in_group("PLAYER"): continue
		if player.is_dead(): continue
		
		var hp = player.health
		if hp < lowest_hp:
			lowest_hp_player = player.global_position
			lowest_hp = hp
	
	return lowest_hp_player
