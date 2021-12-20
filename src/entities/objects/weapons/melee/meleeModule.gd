extends Node2D

export var type = "Melee"

export var damage_value: float =  20
export var knockback_value: float = 50

func find_targets_in_area(target_groups, area):
	var bodies =  area.get_overlapping_bodies()
	var targets = []
	for body in bodies:
		if body.has_method("is_dead") and body.is_dead():
			continue
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
				break
	return targets	
