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
	
func play_animation(animation, node_name):
	find(node_name).play(animation)

func get_animation(animation, node_name):
	return find(node_name).get_animation(animation)

func set_animation(duration, node_name):
	find(node_name).seek(duration, false)
