extends Node

onready var FRICTION = 0.1
onready var ACCEL = 0.1

var brother_1
var brother_2

var navigation

var entity_world
var main
var items
var enemies
var players
var projectiles
var misc
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
	

func random_vector2(n):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return Vector2(rng.randf_range(-n, n), rng.randf_range(-n, n))


func get_all_enemies():
	var enemies_result = {
		"BALL":[],
		"GUNNER":[],
		"IMP":[]
	}

	var enemy_types = enemies_result.keys()
	for entity in enemies.get_children():
#		if not entity.is_in_group("ENTITY"):
#			continue
		if entity.entity_type in enemy_types:
			enemies_result[entity.entity_type].append(entity)
	return enemies_result

func get_all_enemies_list():
#	var enemies = []
#	var enemy_names = ["BALL", "GUNNER", "IMP"]
#
#	for entity in entity_world.get_children():
#		if not entity.is_in_group("ENTITY"):
#			continue
#
#		if entity.entity_name in enemy_names:
#			enemies.append(entity)
#
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
	
	for enemy in enemies.get_children():
		var distance = (position - enemy.global_position).length()
		if distance < closest_distance:
			closest_enemy = enemy.global_position
			closest_distance = distance
	
	return closest_enemy

func get_farthest_enemy(position: Vector2):
	var farthest_enemy: Vector2
	var farthest_distance = 0
	
	if enemies.get_child_count() == 0:
		farthest_enemy = Vector2.ZERO
	else:
		farthest_enemy = enemies.get_children()[0].position
	
	for enemy in enemies.get_children():
		var distance = (position - enemy.global_position).length()
		if distance > farthest_distance:
			farthest_enemy = enemy.global_position
			farthest_distance = distance
	
	return farthest_enemy

func get_heighest_hp_enemy():
	var heighest_hp_enemy: Vector2 = Vector2.ZERO
	var heighest_hp = 0
	
	for enemy in enemies.get_children():
		var hp = enemy.health
		if hp > heighest_hp:
			heighest_hp_enemy = enemy.global_position
			heighest_hp = hp
	
	return heighest_hp_enemy

func get_brother():
	for player in players.get_children():
		if player.entity_type == "PLAYER":
			return player
		#if not player.is_in_group("PLAYER"): continue
	#for player in entity_world.get_children():

func get_closest_player(position: Vector2):
	var closest_player: KinematicBody2D
	var closest_distance = 999999999
	
	for player in players.get_children():
		if player.health_manager.is_dead(): continue
		
		var distance = (position - player.global_position).length()
		if distance < closest_distance:
			closest_player = player
			#closest_player = player.global_position
			closest_distance = distance
	
	return closest_player

func get_farthest_player(position: Vector2):
	var farthest_player: Vector2 = random_vector2(10)
	var farthest_distance = 0

	for player in players.get_children():
		#if not player.is_in_group("PLAYER"): continue
		if player.is_dead(): continue
		
		var distance = (position - player.global_position).length()
		if distance > farthest_distance:
			farthest_player = player.global_position
			farthest_distance = distance
	
	return farthest_player	

func get_lowest_hp_player():
	var lowest_hp_player: Vector2 = random_vector2(10)
	var lowest_hp = 999999999
	
	for player in players.get_children():
		#if not player.is_in_group("PLAYER"): continue
		if player.is_dead(): continue
		
		var hp = player.health
		if hp < lowest_hp:
			lowest_hp_player = player.global_position
			lowest_hp = hp
	
	return lowest_hp_player
