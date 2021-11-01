extends PlatformBotState

var direction

#Dash state

func enter(msg := {}) -> void:
	direction = msg["direction"]
	player.velocity = Vector2.ZERO
	player.dashTimer.start()

func physics_update(delta):
	
	player.velocity.x += 100 * direction
	#player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.is_on_floor() or player.is_on_wall() or player.dashTimer.time_left == 0:
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
