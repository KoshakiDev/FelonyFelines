extends State

func enter(msg := {}) -> void:
	pass

func find_target(target_group) -> PhysicsBody2D:
	var bodies = owner.vision_area.get_overlapping_bodies()
	var target = owner # If no target found
	for body in bodies:
		if body.is_in_group(target_group):
			target = body
	return target

func direction_travelling():
	var angle = owner.velocity.angle()
	print(angle, owner.velocity)
	if PI / 4 >= angle or angle >= -PI / 4: return Vector2(1, 0)
	if PI / 4 <= angle and angle <= 3*PI / 4: return Vector2(0, -1)
	if 3*PI / 4 <= angle or angle >= -3*PI / 4: return Vector2(-1, 0)
	if -3*PI / 4 <= angle and angle >= -PI / 4: return Vector2(0, 1)
	return Vector2(0, 0)

func seek_steering(target) -> Vector2:
	var desired_velocity = (target.position - owner.position).normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func physics_update(delta: float) -> void:
	var target = find_target("player")
	var steering: Vector2 = seek_steering(target)
	steering.clamped(owner.max_steering)
	
	print(direction_travelling())
	
	owner.velocity += steering
	owner.velocity = owner.velocity.clamped(owner.max_speed)
	owner.velocity = owner.move_and_slide(owner.velocity)
