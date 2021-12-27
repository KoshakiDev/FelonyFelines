extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func seek_steering(vector_to_target: Vector2) -> Vector2:
	var desired_velocity: Vector2 = vector_to_target.normalized() * owner.max_speed
	return desired_velocity - owner.velocity
	
func physics_update(delta: float) -> void:
	if owner.is_dead():
		state_machine.transition_to("Death")
	var targets = owner.find_targets_in_area(["player"], owner.vision_area)
	if targets.size() == 0:
		state_machine.transition_to("Idle")
		return
		
	var target = targets[0]
	
	var vector_to_target = target.global_position - owner.global_position
	
	var steering: Vector2 = seek_steering(vector_to_target)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering

	owner.velocity = owner.velocity.clamped(owner.max_speed)

	if owner.find_targets_in_area(["player"], owner.engage_range).size() != 0:
		state_machine.transition_to("Attack")
