extends Node2D

var damage_value: float =  20
var knockback_value: float = 50

func _ready():
	pass
	
func action():
	$AttackAnimationPlayer.play("Attack")
	var enemies = owner.find_targets_in_area(["enemy"], owner.hit_range)
	for enemy in enemies:
		enemy.take_damage(owner, damage_value, knockback_value)
	
	return
