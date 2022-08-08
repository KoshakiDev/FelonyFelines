extends "res://src/entities/base_templates/base_npc/base_npc.gd"

export var cooldown_duration: float = 5

export var dash_duration: float = 3
export var dash_speed: int = 30

onready var hitbox = $Areas/Hitbox
onready var hitbox_shape = $Areas/Hitbox/HitboxShape

export var damage_value: float = 10
export var knockback_value: float = 20


func _turn_on_hitbox():
	hitbox_shape.set_deferred("disabled", false)

func _turn_off_hitbox():
	hitbox_shape.set_deferred("disabled", true)

var dash_direction = Vector2.ZERO


func attack(target):
	dash_direction = (target.global_position - global_position).normalized() * dash_speed
	apply_dash(dash_direction)

func apply_dash(direction):
	intended_velocity = direction * dash_speed

func _on_Hurtbox_area_entered(area):
	if health_manager.is_dead(): return
	._on_Hurtbox_area_entered(area)
	var attacker = area.owner
	var attack_direction
	if area.is_in_group("PROJECTILE"):
		attacker = area
		attack_direction = attacker.dir
	else:
		var attacker_2 = attacker.owner
		attack_direction = attacker_2.intended_velocity
	
	if (attack_direction.x > 0 and sprite.scale.x == 1) or (attack_direction.x < 0 and sprite.scale.x == -1):
		state_machine.transition_to("Pain", {Back = true})
	elif (attack_direction.x > 0 and sprite.scale.x == -1) or (attack_direction.x < 0 and sprite.scale.x == 1):
		state_machine.transition_to("Pain", {Front = true})
	Global.frame_freeze(0.5, 2)

