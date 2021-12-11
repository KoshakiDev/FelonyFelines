extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run")

func seek_steering(vector_to_target: Vector2) -> Vector2:
	var desired_velocity: Vector2 = vector_to_target.normalized() * owner.max_speed
	return desired_velocity - owner.velocity
	
func physics_update(delta: float) -> void:
	var targets = owner.find_targets_in_area(["player1", "player2"], owner.vision_area)
	
	if targets.size() == 0 or owner.controlled:
		state_machine.transition_to("Idle")
		return
		
	var target = targets[0]
	
	var vector_to_target = target.global_position - owner.global_position
	
	var steering: Vector2 = seek_steering(vector_to_target)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering
	print(owner.velocity, owner.velocity.clamped(owner.max_speed))
	owner.velocity = owner.velocity.clamped(owner.max_speed)

	var direction = owner.return_travel_direction(owner.velocity)
	if direction != Vector2.ZERO:
		owner.adjust_blend_position(direction)	
	
	if owner.find_targets_in_area(["player1", "player2"], owner.hit_range).size() != 0:
		state_machine.transition_to("Attack")
		

	
