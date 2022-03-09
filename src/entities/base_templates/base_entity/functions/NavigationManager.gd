extends Node


var path = []
export var threshold = 16


func get_next_direction_to_target():
	if owner.global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	var direction = owner.global_position.direction_to(path[0])
	return direction

func get_position_of_next_target(target_position):
	get_target_path(target_position)

	var i = 0
	while i < path.size():
		var dist = (owner.global_position - path[i]).length();
		if not is_equal_approx(dist, 0.0): 
			return path[i]
		i += 1
	return owner.global_position
	
func get_target_path(target_position):
	path = Global.navigation.get_simple_path(owner.global_position, target_position, false)
	owner.line2d.points = path
