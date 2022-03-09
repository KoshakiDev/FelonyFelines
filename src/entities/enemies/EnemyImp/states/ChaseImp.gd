extends State

export var neighborhood_distance = 10
export var desired_separation = 1

func ent_dist(entity1, entity2):
	return (entity1.global_position - entity2.global_position).length()

func limit(vector: Vector2, max_length: float):
	if vector.length() > max_length:
		vector = vector.normalized()
		vector *= max_length
	return vector

func boid_cohesion(entities: Array):
	var sum: Vector2 = Vector2.ZERO
	var count = 0
	
	for entity in entities:
		var d = ent_dist(owner, entity)
		if(d > 0 and d < neighborhood_distance):
			sum += entity.global_position
			count += 1
	if(count > 0):
		sum /= count
		
		return boid_seek(sum)
	else:
		return Vector2.ZERO

func boid_alignment(entities: Array):
	var sum: Vector2 = Vector2.ZERO
	var count = 0
	
	for entity in entities:
		var d = ent_dist(owner, entity)
		if(d > 0 and d < neighborhood_distance):
			sum += entity.intended_velocity
			count += 1
	
	if(count > 0):
		sum /= count
		
		sum = sum.normalized()
		sum *= owner.max_speed

		var steer = sum - owner.intended_velocity
		return limit(steer, owner.max_speed)
	else:
		return Vector2.ZERO

func boid_separate(entities: Array):
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
		steer -= owner.intended_velocity
	
	return limit(steer, owner.max_speed)

func boid_seek(target: Vector2):
	var desired_velocity = target - owner.global_position

	if(desired_velocity.length() > 0):
		desired_velocity = desired_velocity.normalized()
		desired_velocity *= owner.max_speed
		

		var steer = desired_velocity - owner.intended_velocity
		return limit(steer, owner.max_speed)
	else:
		return Vector2.ZERO

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

	var seek_target = owner.nav_manager.get_position_of_next_target(target.global_position)

	var cohesion = boid_cohesion(similar_enemies)
	var alignment = boid_alignment(similar_enemies)
	var separate = boid_separate(similar_enemies)
	var seek = boid_seek(seek_target)

	print(seek_target, owner.global_position)

	var steering: Vector2 = Vector2.ZERO
	
	# TODO: Find best weights
	steering += cohesion  * 0.3
	steering += alignment * 0.2
	steering += separate  * 0.3
	steering += seek	  * 0.2

	owner.move(steering)
	
	if owner.is_target_in_aim(target) and owner.current_bodies_in_attack_range.size() > 0:
		state_machine.transition_to("Attack")
		return
