extends State

export var neighborhood_distance = 300
export var desired_separation = 50

func ent_dist(entity1, entity2):
	return (entity1.global_position - entity2.global_position).length()

func limit(vector: Vector2, max_length: float):
	if vector.length() > max_length:
		vector = vector.normalized()
		vector *= max_length
	return vector

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

func boid_seek(target):
	var desired_velocity = target - owner.global_position

	desired_velocity = desired_velocity.normalized()
	desired_velocity *= owner.max_speed
	
	var steer = desired_velocity - owner.intended_velocity
	return limit(steer, owner.max_speed)


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
	
	if owner.nav_manager.can_update_path:
		owner.nav_manager.get_target_path(target_pos)
		owner.nav_manager.update_path_timer.start()
	
	
	if owner.nav_manager.path.size() > 0:
		var local_target_pos = owner.nav_manager.get_next_target()
		if not local_target_pos:
			return

		var cohesion = boid_cohesion(similar_enemies)
		var alignment = boid_alignment(similar_enemies)
		var separate = boid_separate(similar_enemies)
		var seek = boid_seek(local_target_pos)

		var steering: Vector2 = Vector2.ZERO

		# TODO: Find best weights
		steering += cohesion  * 0.1
		steering += alignment * 0.25
		steering += separate  * 0.45
		steering += seek      * 0.25

		steering = limit(steering, owner.max_speed)

		owner.move(steering)
	
	if owner.is_target_in_aim(target) and owner.current_bodies_in_attack_range.size() > 0:
		state_machine.transition_to("Attack")
		return
