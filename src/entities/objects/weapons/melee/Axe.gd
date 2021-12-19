extends "res://src/entities/objects/weapons/melee/WeaponMeleeModule.gd"

func action():
	$AttackAnimationPlayer.play("Attack")
	var enemies = find_targets_in_area(["enemy"], $HitRange)
	for enemy in enemies:
		enemy.take_damage(owner, damage_value, knockback_value)
	return
