extends Position2D

export var heal_value = 20

onready var anim_player = $AnimationPlayer

onready var area = $Area2D

func find_targets(target_groups):
	var bodies = area.get_overlapping_bodies()
	var targets = []
	for body in bodies:
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
	return targets

func _ready():
	anim_player.play("idle")

func _process(delta):
	var targets = find_targets(["player"])
	if targets.size() == 0:
		return
		
	var target = targets[0]
	
	target.health = target.heal(target.health, target.max_health, heal_value)
	
	queue_free()
