extends State

export var damage_value: float = 10
export var knockback_value: float = 50

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
		
	owner.damage_area(targetGroups, owner.hit_range, damage_value, knockback_value)
