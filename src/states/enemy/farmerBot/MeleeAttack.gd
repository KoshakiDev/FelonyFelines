extends PlatformBotState

var direction_x

func enter(_msg := {}) -> void:
	player.armAnimation.play("meleeAttack")
	if _msg.has("direction"):
		direction_x = _msg["direction"]
		player.animationPlayer.play("walk")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	if not player.attackTrigger.are_rays_colliding():
		player.armAnimation.play("armIdle")
		state_machine.transition_to("Walk", {direction=direction_x})
	if direction_x != 0:
		player.sprite.scale.x = direction_x
		player.armController.flip_arms(direction_x)
	player.velocity.x = player.walk_speed * direction_x
	player.velocity.y += player.gravity * _delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
