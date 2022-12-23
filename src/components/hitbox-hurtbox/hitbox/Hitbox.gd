extends Area2D


var attacker = null
export var damage_value: float = 1
export var knockback_value: float  = 1

func turn_off_hitbox():
	monitorable = false
	monitoring = false

func turn_on_hitbox():
	monitorable = true
	monitoring = true

func init(_attacker):
	attacker = _attacker
