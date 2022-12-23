extends State


func enter(msg := {}) -> void:
	owner.play_animation("Idle", "Animations")

func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return
	
	var target = owner.search_for_target()
	if target != null:
		state_machine.transition_to("Chase")
		return
	
	#for look in owner.search_directions.get_children():
	var search_directions = owner.search_directions.get_children()
	var direction = owner.global_position.direction_to(search_directions[randi() % search_directions.size()].position)
	#owner.movement.move(direction)
		
