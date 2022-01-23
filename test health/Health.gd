extends Node


signal max_health_changed(new_max_health)
signal health_changed(new_health)
signal no_health

export(float) var max_health = 100 setget set_max_health
onready var health = max_health setget set_health

func set_max_health(new_max_health):
	max_health = new_max_health
	max_health = max(1, new_max_health)
	emit_signal("max_health_changed", max_health)

func set_health(new_value):
	health = new_value
	health = clamp(health, 0, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

onready var healthbar = $HealthBar

func _ready():
	connect("health_changed", healthbar, "set_value")
	connect("max_health_changed", healthbar, "set_max")
	_initialize_health()

func _initialize_health():
	emit_signal("max_health_changed", max_health)
	emit_signal("health_changed", health)


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			health -=1
			set_health(health)
