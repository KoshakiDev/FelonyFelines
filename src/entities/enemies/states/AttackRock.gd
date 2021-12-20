extends State

onready var cooldown_timer = $Cooldown

export var cooldown_duration = 0.5

var pelletPreload = preload("res://src/entities/objects/Pellet.tscn")

func enter(msg := {}) -> void:
	if !cooldown_timer.is_stopped():
		state_machine.transition_to("Chase")
		return
	
	cooldown_timer.wait_time = cooldown_duration
	cooldown_timer.start()
	
	owner.play_animation("Attack", "Animations")
	
	yield(owner.animation_machine.find("Animations"), "animation_finished")
	
	state_machine.transition_to("Chase")
	pass


func bullet_spawner_set_shooting_true():
	owner.bullet_spawner.set_shooting(true)

func bullet_spawner_set_shooting_false():
	owner.bullet_spawner.set_shooting(false)


func shootPellet():
	var targets = owner.find_targets_in_area(["player"], owner.engage_range)
	if targets.size() == 0:
		state_machine.transition_to("Chase")
		return
	var target = targets[0]
	
	var direction = target.global_position - owner.global_position
	
	#shoot(direction)

	var pellet = pelletPreload.instance()
	owner.pellets.add_child(pellet)

	pellet.set_as_toplevel(true)
	pellet.position = owner.pellets.global_position
	pellet.direction = direction.normalized()

