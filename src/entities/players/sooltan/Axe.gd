extends Sprite

var damage_value: float =  20

func _ready():
	pass
	
func action():
	print("Axe attack!")
	
	var enemies = owner.enemies_detection_system()
	for enemy in enemies:
		enemy.health = enemy.health_bar.take_damage(enemy.health, enemy.max_health, damage_value)
	return
