extends State

func ent_dist(entity1, entity2):
	return (entity1.global_position - entity2.global_position).length()

func boid_cohesion(entities: Array):
	var neighborhood_distance = 300
	var sum: Vector2 = Vector2.ZERO
	var count = 0
	
	for entity in entities:
		var d = ent_dist(owner, entity)
		if(d > 0 and d < neighborhood_distance):
			sum += entity.global_position
			count += 1
	if(count > 0):
		sum /= count
		
		var steer = sum - owner.global_position
		return steer
	else:
		return Vector2.ZERO

func boid_alignment(entities: Array):
	var neighborhood_distance = 300
	var sum: Vector2 = Vector2.ZERO
	var count = 0
	
	for entity in entities:
		var d = ent_dist(owner, entity)
		if(d > 0 and d < neighborhood_distance):
			sum += entity.velocity
			count += 1
	
	if(count > 0):
		sum /= count
		sum = sum.normalized()
		sum *= owner.max_speed
		var steer = sum - owner.velocity
		return steer
	else:
		return Vector2.ZERO

func boid_separate(entities: Array):
	var desired_separation = 200
	var steer: Vector2 = Vector2.ZERO
	var count = 0
	for entity in entities:
		var d = ent_dist(owner, entity)
		if(d > 0 and d < desired_separation):
			var diff = owner.global_position - entity.global_position
			diff = diff.normalized()
			diff /= d
			steer += diff
			count += 1
	if(count > 0):
		steer /= count
		
	if(steer.length() > 0):
		steer = steer.normalized()
		steer *= owner.max_speed
		steer -= owner.velocity
	
	return steer

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")


func physics_update(delta: float) -> void:
	if owner.health_manager.is_dead():
		state_machine.transition_to("Death")
		return

	var similar_enemies = Global.get_all_enemies()[owner.entity_name]
	
	var target = Global.get_closest_player(owner.global_position)
	
	if target == null:
		state_machine.transition_to("Idle")
		return
	var target_pos = target.global_position
	var total_vector

	if owner.global_position.distance_to(target_pos) > 300:
		owner.nav_manager.get_target_path(target_pos)
		# direction of motion
		if owner.nav_manager.path.size() > 0:
			var vector_to_target = owner.nav_manager.get_next_direction_to_target()
			owner.move(vector_to_target)
	else:
		# direction of motion
		var vector_to_target = target_pos - owner.global_position

		if len(similar_enemies) > 1:
			var c = boid_cohesion(similar_enemies)
			var a = boid_alignment(similar_enemies)
			var s = boid_separate(similar_enemies)

			total_vector = vector_to_target * .3 + c * .2 + a * .2 + s * .3
		else:
			total_vector = vector_to_target
		owner.move(total_vector)
	if owner.is_target_in_aim(target) and owner.current_bodies_in_attack_range.size() > 0:
		state_machine.transition_to("Attack")
		return
