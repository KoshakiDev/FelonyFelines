extends State

func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")

func exit() -> void:
	owner.bullet_spawner.set_shooting(false)

func physics_update(_delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	var target = Global.get_closest_player(owner.global_position)
	if target == null:
		state_machine.transition_to("Idle")
		return
	if !owner.is_target_in_aim(target) or owner.current_bodies_in_attack_range.size() == 0:
		state_machine.transition_to("Chase")
		return
	owner.aim(target)
