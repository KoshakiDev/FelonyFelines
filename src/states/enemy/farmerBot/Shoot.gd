extends PlatformBotState

var direction_x
#Shoot
func enter(_msg := {}) -> void:
	#player.armAnimation.play("meleeAttack")
	player.animationPlayer.play("idle")
	if _msg.has("direction"):
		direction_x = _msg["direction"]
		player.velocity.x = 500 * direction_x
		

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	player.velocity.y += player.gravity * _delta
	if !player.attackTrigger.are_rays_colliding() and player.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle")
		return
	#player.velocity.x = player.velocity.x.linear_interpolate(0, _delta * 5)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
