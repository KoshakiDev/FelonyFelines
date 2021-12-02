extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run")

func seek_steering(vector_to_target: Vector2) -> Vector2:
	var desired_velocity: Vector2 = vector_to_target.normalized() * owner.max_speed
	return desired_velocity - owner.velocity
	
	
func arrival_steering(vector_to_target: Vector2) -> Vector2:
	var speed: float = (vector_to_target.length() / owner.arrival_zone_radius) * owner.max_speed
	var desired_velocity: Vector2 = vector_to_target.normalized() * speed
	return desired_velocity - owner.velocity
	
	
func avoid_obstacles_steering() -> Vector2:
	owner.raycasts.rotation = owner.velocity.angle()
	
	for raycast in owner.raycasts.get_children():
		raycast.cast_to.x = owner.velocity.length()
		if raycast.is_colliding():
			var obstacle: PhysicsBody2D = raycast.get_collider()
			return (owner.position + owner.velocity - obstacle.position).normalized() * owner.avoid_force
			
	return Vector2.ZERO

func physics_update(delta: float) -> void:
	var targets = owner.find_targets_in_area(["player1", "player2"], owner.vision_area)
	
	if targets.size() == 0 or owner.controlled:
		state_machine.transition_to("Idle")
		return
		
	var target = targets[0]
	
	var vector_to_target = target.position - owner.position
	
	var steering: Vector2
		
	if vector_to_target.length() > owner.arrival_zone_radius:
		steering += seek_steering(vector_to_target)
	else:
		steering += arrival_steering(vector_to_target)
	steering.clamped(owner.max_steering)
	
	
	var direction = owner.return_travel_direction()
	if direction != Vector2.ZERO:
		owner.adjust_blend_position(direction)

	steering += avoid_obstacles_steering()
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity += steering
	owner.velocity = owner.velocity.clamped(owner.max_speed)
	
	owner.velocity = owner.move_and_slide(owner.velocity)
	
	if owner.find_targets_in_area(["player1", "player2"], owner.hit_range).size() != 0:
		state_machine.transition_to("Attack")
