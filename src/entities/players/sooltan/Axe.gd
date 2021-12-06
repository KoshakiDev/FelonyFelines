extends Sprite

var damage_value: float =  20

func _ready():
	pass
	
func action():
	print("Axe attack!")
	
	var enemies = owner.find_targets_in_area(["enemy"], owner.hit_range)
	for enemy in enemies:
		enemy.health = enemy.take_damage(enemy.health, enemy.max_health, damage_value)
	return
