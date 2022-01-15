extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")

func seek_steering(desired_direction_vector: Vector2) -> Vector2:
	var desired_velocity: Vector2 = desired_direction_vector.normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func move_according_to(vector):
	var steering: Vector2 = seek_steering(vector)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering

	owner.velocity = owner.velocity.clamped(owner.max_speed)

func physics_update(_delta: float) -> void:
	
	var vector_to_center = Vector2.ZERO - owner.global_position
	move_according_to(vector_to_center)
	
	if owner.find_targets_in_area(["player"], owner.vision_area).size() == 0:
		state_machine.transition_to("Idle")
	else:
		state_machine.transition_to("Chase")
