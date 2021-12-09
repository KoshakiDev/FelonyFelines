extends Area2D

var speed = 10
var damage_value = 10

func find_targets(target_groups):
	var bodies = get_overlapping_bodies()
	var targets = []
	for body in bodies:
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
	return targets


func _physics_process(delta):
	position += transform.x * speed * delta
	
	var targets = find_targets(["player1", "player2"])
	for target in targets:
		target.health = target.health_bar.take_damage(target.health, target.max_health, damage_value)
		queue_free()

