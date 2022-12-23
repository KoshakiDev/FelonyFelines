extends State

"""
Knockout State for Burglar mode enemies
"""

onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "timeout")

func enter(msg := {}) -> void:
	owner.turn_off_all()
	owner.sound_machine.play_sound("Death")
	owner.play_animation("Death", "Animations")
	timer.start()
	
func timeout():
	owner.health_manager.heal(1)
	owner.turn_on_all()
	state_machine.transition_to("Idle")
