extends State

onready var cooldown_timer = $Cooldown

export var cooldown_duration: int = 5


func enter(msg := {}) -> void:
	if !cooldown_timer.is_stopped():
		state_machine.transition_to("Chase")
		return
	
	cooldown_timer.wait_time = cooldown_duration
	cooldown_timer.start()
	owner.attack_sound.play()
	owner.play_animation("Attack", "Animations")
	
	yield(owner.animation_machine.find("Animations"), "animation_finished")
	
	state_machine.transition_to("Chase")
