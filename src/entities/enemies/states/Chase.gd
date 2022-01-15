extends State

func enter(msg := {}) -> void:
	owner.play_animation("Run", "Animations")

func seek_steering(desired_direction_vector: Vector2) -> Vector2:
	var desired_velocity: Vector2 = desired_direction_vector.normalized() * owner.max_speed
	return desired_velocity - owner.velocity

func ent_dist(entity1, entity2):
	return (entity1.global_position - entity2.global_position).length()

func farthest_target(targets: Array):
	var max_id = 0
	for i in range(len(targets)):
		if(ent_dist(owner, targets[i]) > ent_dist(owner, targets[max_id])):
			max_id = i
	return targets[max_id]

func closest_target(targets: Array):
	var min_id = 0
	for i in range(len(targets)):
		if(ent_dist(owner, targets[i]) < ent_dist(owner, targets[min_id])):
			min_id = i
	return targets[min_id]

func lowest_hp_target(targets: Array):
	var min_id = 0
	for i in range(len(targets)):
		if(targets[i].health < targets[min_id].health):
			min_id = i
	return targets[min_id]

func highest_hp_target(targets: Array):
	var max_id = 0
	for i in range(len(targets)):
		if(targets[i].health > targets[max_id].health):
			max_id = i
	return targets[max_id]

# todo
func get_out_of_spawn():
	return Vector2.ZERO
func in_spawn():
	return false

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
	var desired_separation = 50
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

func physics_update(delta: float) -> void:
	
	var similar_enemies = Global.get_all_enemies()[owner.type]
	
	if owner.is_dead():
		state_machine.transition_to("Death")
	var targets = owner.find_targets_in_area(["player"], owner.vision_area)
	if targets.size() == 0:
		state_machine.transition_to("Idle")
		return
		
	
	var target
	var total_vector
	
	# strategy to choose targets
	if(owner.type == "imp"):
		target = lowest_hp_target(targets)
	elif(owner.type == "rock"):
		target = closest_target(targets)
	elif(owner.type == "scissors"):
		target = farthest_target(targets)
	else:
		target = closest_target(targets)
	
	
	# direction of motion
	var vector_to_target = target.global_position - owner.global_position
	
	if(owner.type == "imp" and len(similar_enemies) > 1):
		var c = boid_cohesion(similar_enemies)
		var a = boid_alignment(similar_enemies)
		var s = boid_separate(similar_enemies)
		
		total_vector = vector_to_target * .3 + c * .2 + a * .2 + s * .3
	elif(owner.type == "rock"):
		if(ent_dist(owner, target) < 50):
			total_vector = -vector_to_target
		else:
			total_vector = vector_to_target
	else:
		total_vector = vector_to_target
	
	# moving into the direction
	var steering: Vector2 = seek_steering(total_vector)
	steering = steering.clamped(owner.max_steering)
	
	owner.velocity = owner.velocity + steering

	owner.velocity = owner.velocity.clamped(owner.max_speed)

	if owner.find_targets_in_area(["player"], owner.engage_range).size() != 0:
		state_machine.transition_to("Attack")
