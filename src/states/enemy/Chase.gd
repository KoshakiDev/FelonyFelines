extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run")

func seek_steering(target) -> Vector2:
	var desired_velocity = (target.position - owner.position).normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func physics_update(delta: float) -> void:
	var target = owner.find_target("player")
	
	var steering: Vector2 = seek_steering(target)
	steering.clamped(owner.max_steering)
	
	var direction = owner.return_travel_direction()
	if direction != Vector2.ZERO:
		owner.adjust_blend_position(direction)

	owner.velocity += steering
	owner.velocity = owner.velocity.clamped(owner.max_speed)
	owner.velocity = owner.move_and_slide(owner.velocity)

	if owner.find_target_check("player") == false or owner.controlled:
		state_machine.transition_to("Idle")
		return
