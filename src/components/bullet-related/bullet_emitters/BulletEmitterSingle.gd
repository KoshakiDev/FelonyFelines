class_name BulletEmitterSingle
extends BulletEmitter

# The spread of the bullets in degree
export var spread := 10

func shoot(position: Vector2, dir: Vector2, speed: float):
	shoot_single(position, dir.rotated(deg2rad(rand_range(-spread, spread))), speed)
