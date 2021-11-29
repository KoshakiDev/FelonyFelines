extends State

#shared player move state

func enter(msg := {}) -> void:
	pass

func physics_update(delta: float) -> void:
	var target = owner.in_range_hit("player")
	
	if target == null: # No target found
		return
		
	target.take_damage(owner.damage_value)
	
