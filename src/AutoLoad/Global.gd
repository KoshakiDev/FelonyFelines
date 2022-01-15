extends Node

onready var FRICTION = 0.1

var brother_1
var brother_2
var parent_location
var main
var items
var root 

var final_score
var wave_survived


var ITEM_DROP_WEIGHTS = {
	"weapons/melee/axe/Axe": 2,
	"weapons/melee/fists/Fists": 3,
	"weapons/melee/spear/Spear": 2,
	"weapons/range/assault rifle/AssaultRifle": 1,
	"weapons/range/shotgun/Shotgun": 1,
	
	"medkit/Medkit": 5
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
		"scissors":[],
		"rock":[],
		"imp":[]
	}
	
	var enemy_types = enemies.keys()
	
	for spawner in main.spawners:
		var result = []
		var entities = spawner.parent.get_children()
		for entity in entities:
			# Checker if its an enemy, if true then add it to result
			if("type" in entity):
				if(entity.type in enemy_types):
					enemies[entity.type].append(entity)
	
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
