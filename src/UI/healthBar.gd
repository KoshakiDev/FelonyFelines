extends TextureRect

func _ready():
	$TextureProgress.value = 100


func take_damage(health, max_health, damage_value):
	health = health - damage_value
	if health < 0: return 0
	set_percent_value(health / max_health * 100)
	return health 

func set_percent_value(value):
	$TextureProgress.value = value
