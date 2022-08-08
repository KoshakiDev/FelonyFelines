extends State

onready var duration_timer = $DashDurationTimer
onready var cooldown_timer = $Cooldown

func enter(msg := {}) -> void:
	if !cooldown_timer.is_stopped():
		state_machine.transition_to("Chase")
		return
	start_cooldown_timer()
	calculate_dash_direction()
	owner.play_animation("Attack", "Animations")
	owner.attack_sound.play()
	owner._turn_on_hitbox()

func exit() -> void:
	owner.dash_direction = Vector2.ZERO
	owner._turn_off_hitbox()

func physics_update(delta):
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	if is_dashing():
		owner.apply_dash(owner.dash_direction)

func calculate_dash_direction():
	var target = Global.get_farthest_player(owner.global_position)
	if target == null:
		state_machine.transition_to("Idle")
		return
	if !owner.is_target_in_aim(target) or owner.current_bodies_in_attack_range.size() == 0:
		state_machine.transition_to("Chase")
		return
	owner.aim(target)

func start_cooldown_timer():
	cooldown_timer.wait_time = owner.cooldown_duration
	cooldown_timer.start()

func start_dash():
	duration_timer.wait_time = owner.dash_duration
	duration_timer.start()

func end_dash():
	if is_dashing():
		owner.set_animation(0.3, "Animations")
	else:
		yield(owner.animation_machine.find("Animations"), "animation_finished")
		state_machine.transition_to("Chase")
		pass

func is_dashing():
	return !duration_timer.is_stopped()
