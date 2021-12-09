extends State

var pelletPreload = preload("res://src/entities/enemies/Pellet.tscn")

func enter(msg := {}) -> void:
	print(pelletPreload)
	pass

func physics_update(delta: float) -> void:
	owner.play_animation("Attack")
	yield(owner.anim_player, "animation_finished")
	
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
	
	
	var pellet = pelletPreload.instance()
	owner.pellets.add_child(pellet)
	pellet.transform = owner.pellets.global_transform - target.global_transform
	
	print(pellet, owner.pellets.children().size())

	state_machine.transition_to("Chase")
	pass
