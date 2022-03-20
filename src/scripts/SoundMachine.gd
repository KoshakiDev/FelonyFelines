extends Node

onready var children = get_children()

func _ready():
	pass

func get_node_name(node):
	return str(node.name.replace("@", "").replace(str(int(node.name)), ""))

func find(node_name):
	for node in children:
		if get_node_name(node) == node_name:
			return node
	
func play_sound(node_name):
	randomize()
	var pitch_scale = rand_range(0.8, 1.5)
	find(node_name).pitch_scale = pitch_scale
	find(node_name).play()

func get_sound(node_name):
	return find(node_name)
