extends TextureProgress

#THIS ONLY CONTROLS THE REPRESENTATION, THERE IS ALSO HEALTH IN THE ENTITY MODULE

var healthbar: float setget set_healthbar
var max_healthbar: float setget set_max_healthbar

func set_healthbar(value):
	print(value)
	healthbar = clamp(value, 0, max_healthbar)
	set_percent_value(healthbar / max_healthbar * 100)

func set_max_healthbar(value):
	max_healthbar = max(value, 1)

func _ready():
	pass
#	print(owner, owner.max_health, owner.health)
#	if owner.health == null:
#		owner.health = owner.max_health
#	max_healthbar = owner.max_health
#	healthbar = owner.health

func set_percent_value(value):
	$TextureProgress.value = value
