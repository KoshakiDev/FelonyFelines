class_name BulletEmitterSpread
extends BulletEmitter

# the amount of bullets shot in a spread
export var amount := 3
# the angle between each of the bullets in degree
export var spread_angle: float = 5

func shoot(position: Vector2, dir: Vector2, speed: float):
	spread_shoot(position, dir, speed)

func spread_shoot(position: Vector2, dir: Vector2, speed: float):
	var directions = []
	var angle := deg2rad(spread_angle)
	var start_angle := amount/2.0 * angle
	for i in range(amount):
		shoot_single(position, dir.rotated(start_angle - angle * i), speed)
