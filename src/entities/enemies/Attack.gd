extends State

func enter(msg := {}) -> void:
	pass

func physics_update(delta: float) -> void:
	var target = owner.in_range_hit("player")
	if target == null or target == owner:
		state_machine.transition_to("Chase")
		return
	target.health = target.health_bar.take_damage(target.health, target.max_health, owner.damage_value)
