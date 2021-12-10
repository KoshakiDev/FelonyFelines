extends State

var pelletPreload = preload("res://src/entities/enemies/Pellet.tscn")

func enter(msg := {}) -> void:
	owner.play_animation("Attack")
	
	yield(owner.anim_player, "animation_finished")
	
	state_machine.transition_to("Chase")
	pass

func shootPellet():
	var targetGroups
	if owner.controlled:
		targetGroups = ["enemy"]
	else:
		targetGroups = ["player1", "player2"]
	var targets = owner.find_targets_in_area(targetGroups, owner.hit_range)
	if targets.size() == 0:
		state_machine.transition_to("Chase")
		return
	var target = targets[0]
	
	var direction = target.global_position - owner.global_position
	
	var pellet = pelletPreload.instance()
	owner.pellets.add_child(pellet)
	
	pellet.set_as_toplevel(true)
	pellet.position = owner.pellets.global_position
	pellet.direction = direction.normalized()

