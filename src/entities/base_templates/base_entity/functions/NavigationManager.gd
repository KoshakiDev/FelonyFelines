extends Node


var path = []
export var threshold = 16

var can_update_path = true
onready var update_path_timer = $UpdatePathTimer


func get_next_direction_to_target():
	if owner.global_position.distance_to(path[0]) < threshold:
		path.remove(0)
		
	if path.size() > 0:
		var direction = owner.global_position.direction_to(path[0])
		return direction
	
func get_next_target():
	if owner.global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	if path.size() > 0:
		return path[0]

func get_target_path(target_position):
	path = Global.navigation.get_simple_path(owner.global_position, target_position, false)
	can_update_path = false

func _on_UpdatePathTimer_timeout():
	can_update_path = true
	#print("can update path")
