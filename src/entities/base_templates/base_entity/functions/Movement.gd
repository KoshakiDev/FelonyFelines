extends Node2D

var base_speed = 500
export var speed_percentage: float = 1

var actual_velocity: Vector2
var intended_velocity: Vector2
var knockback: Vector2

func get_actual_velocity():
	return actual_velocity

func get_intended_velocity():
	return intended_velocity

func vector_to_movement_direction(input_vector : Vector2) -> Vector2:
	if input_vector == Vector2.ZERO:
		return Vector2.ZERO
	var aspect = abs(input_vector.aspect())
	var result = input_vector.sign()
	if aspect < 0.557852 or aspect > 1.79259:
		result[int(aspect > 1.0)] = 0
	return result

func move(force: Vector2):
	var force_direction = force.normalized()
	intended_velocity = intended_velocity.linear_interpolate(force_direction * base_speed * speed_percentage, Global.ACCEL)

func apply_knockback(force: Vector2, knockback_value):
	var force_direction = force.normalized()
	knockback = force_direction * knockback_value

func _physics_process(delta):
	actual_velocity = intended_velocity + knockback
	apply_friction()

func apply_friction():
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	intended_velocity = intended_velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)
