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
