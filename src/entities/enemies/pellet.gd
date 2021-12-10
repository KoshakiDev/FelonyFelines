extends Area2D

export var speed = 250
export var damage_value:float = 10
export var knockback_value: float = 20

var direction

func find_targets(target_groups):
	var bodies = get_overlapping_bodies()
	var targets = []
	for body in bodies:
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
	return targets


func _physics_process(delta):
	position += direction * speed * delta
	
	if find_targets(["wall"]).size() > 0:
		queue_free()
		return
	
	
	
	var targets = find_targets(["player1", "player2"])
	for target in targets:
		target.health = target.take_damage(target.health, target.max_health, damage_value)
		target.knockback = (target.position - position).normalized() * knockback_value
		queue_free()
		break

