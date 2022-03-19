extends Node

#HEALTH MANAGER
signal max_health_changed(new_max_health)
signal health_changed(new_health)
signal no_health

export(float) var max_health = 1 setget set_max_health
onready var health = max_health setget set_health

func set_max_health(new_max_health):
	max_health = new_max_health
	max_health = max(1, new_max_health)
	emit_signal("max_health_changed", max_health)

func set_health(new_value):
	health = new_value
	health = clamp(health, 0, max_health)
	emit_signal("health_changed", health)
	if is_dead():
		#self.state_machine.transition_to("Death")
		emit_signal("no_health")

#this function is called from the entity itself
func _initialize_health_bar(health_bar):
	connect("health_changed", health_bar, "set_value")
	connect("max_health_changed", health_bar, "set_max")
	emit_signal("max_health_changed", max_health)
	emit_signal("health_changed", health)

func heal(heal_value):
	health += heal_value
	set_health(health)

func take_damage(attacker):
	var damage_value = attacker.damage_value
	var knockback_value = attacker.knockback_value
	var attacker_pos = attacker.global_position
	owner.knockback = (owner.global_position - attacker_pos).normalized() * knockback_value
	set_health(health - damage_value)
	return

func is_dead():
	return is_equal_approx(health, 0)

