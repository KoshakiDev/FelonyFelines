extends State

onready var cooldown_timer = $Cooldown

export var cooldown_duration: int = 5

export var damage_value: float = 3
export var knockback_value: float = 125

func enter(msg := {}) -> void:
	if !cooldown_timer.is_stopped():
		state_machine.transition_to("Chase")
		return
	
	cooldown_timer.wait_time = cooldown_duration
	cooldown_timer.start()

	owner.play_animation("Attack", "Movement")
	
	yield(owner.animation_machine.find("Movement"), "animation_finished")
	
	state_machine.transition_to("Chase")

func initiate_special_attack():
	owner.damage_area(["player"], owner.hit_range, damage_value, knockback_value)
