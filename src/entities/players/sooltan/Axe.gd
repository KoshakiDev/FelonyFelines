extends Sprite

var damage_value: float =  20

var item_name: String = "AXE"


func _ready():
	pass
	
func action():
	print("Axe attack!")
	
	var enemies = owner.enemies_detection_system()
	print(enemies)
	for enemy in enemies:
		enemy.take_damage(damage_value)
	return
