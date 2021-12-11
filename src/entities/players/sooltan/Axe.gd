extends Sprite

var damage_value: float =  20
var knockback_value: float = 50

func _ready():
	pass
	
func action():
	#print("Axe attack!")
	
	var enemies = owner.find_targets_in_area(["enemy"], owner.hit_range)
	for enemy in enemies:
		enemy.health = enemy.take_damage(enemy.health, enemy.max_health, damage_value)
		enemy.knockback = (enemy.global_position - owner.global_position).normalized() * knockback_value
	
	var bullets = owner.find_targets_in_area(["bullet"], owner.hit_range)
	for bullet in bullets:
		bullet.queue_free()
	return
