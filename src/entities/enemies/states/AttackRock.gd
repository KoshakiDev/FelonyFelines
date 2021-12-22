extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")
	owner.bullet_spawner.set_shooting(true)

func exit() -> void:
	owner.cannon.rotation_degrees = 0
	owner.bullet_spawner.set_shooting(false)

func physics_update(_delta: float) -> void:
	var targets = owner.find_targets_in_area(["player"], owner.engage_range)
	if targets.size() == 0:
		state_machine.transition_to("Chase")
		return
		
	var target = targets[0]
	owner.cannon.look_at(target.global_position)
	var look_dir = (target.global_position - owner.global_position).normalized()
	if look_dir.x < 0:
		owner.sprite.scale.x = -1
	else:
		owner.sprite.scale.x = 1
