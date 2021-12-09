extends State

func enter(msg := {}) -> void:
	owner.play_animation("Attack")
	
	yield(owner.anim_player, "animation_finished")
	
	state_machine.transition_to("Chase")

func initiate_special_attack():
	var targetGroups
	if owner.controlled:
		targetGroups = ["enemy"]
	else:
		targetGroups = ["player1", "player2"]
		
	var targets = owner.find_targets_in_area(targetGroups, owner.hit_range)
	for target in targets:
		target.health = target.health_bar.take_damage(target.health, target.max_health, owner.damage_value)
