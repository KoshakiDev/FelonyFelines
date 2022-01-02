extends Node

onready var FRICTION = 0.1

var brother_1
var brother_2
var parent_location
var main
var root 

var final_score
var wave_survived

func _ready():
	root = get_parent()
	
enum WEAPON_SLOT {
	AXE,
	SNIPER_RIFLE,
}

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
