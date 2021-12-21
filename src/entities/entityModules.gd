extends KinematicBody2D 

var velocity: Vector2
var knockback: Vector2

export var max_health: float = 100
var health: float = max_health

export var max_speed: float = 225

var is_vision_area_empty = true
var allow_attack = false


func is_dead():
	return health <= 0

func play_animation(animation, node_name):
	self.animation_machine.play_animation(animation, node_name)

func set_animation(duration, node_name):
	self.animation_machine.set_animation(duration, node_name)

func get_animation(animation, node_name):
	return self.animation_machine.get_animation(animation, node_name)


func adjust_direction(direction):
	if direction.x != 0:
		self.sprite.scale.x = direction.x

	if "hand_position" in self:
		adjust_hand_rotation(direction)
	
func adjust_hand_rotation(direction):
	if direction.x != 0:
		self.hand_position.scale.y = direction.x
	self.hand_position.look_at(self.hand_position.global_position + direction)
	#print(direction)

func damage_area(targetGroups, hit_range, damage_value, knockback_value):
	var targets = find_targets_in_area(targetGroups, hit_range)
	for target in targets:
		target.take_damage(self, damage_value, knockback_value)
	
func find_targets_in_area(target_groups, area):
	var bodies = area.get_overlapping_bodies()
	var targets = []
	for body in bodies:
		if body.has_method("is_dead") and body.is_dead():
			continue
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
				break
	return targets

func return_travel_direction(vector):
	var x_direction = 1
	var y_direction = 1
	var max_speed = vector.length()
	if max_speed != 0:
		x_direction = stepify(vector.x / max_speed, 1)
		y_direction = stepify(vector.y / max_speed, 1)
	return Vector2(x_direction, y_direction)

func take_damage(attacker):
	var damage_value = attacker.damage_value
	var knockback_value = attacker.knockback_value
	var attacker_pos = attacker.global_position
	play_animation("Hit", "Hit")
	var new_health = self.health_bar.take_damage(health, max_health, damage_value)

	knockback = (global_position - attacker_pos).normalized() * knockback_value
	if new_health <= 0:
		self.state_machine.transition_to("Death")
	health = new_health
	if "is_projectile" in attacker:
		attacker.queue_free()
	return

func heal(heal_value):
	var new_health = self.health_bar.heal(health, max_health, heal_value)
	health = new_health

func _physics_process(delta):
	velocity = velocity + knockback

	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	
	move_and_slide(velocity)
	

func _on_VisionArea_body_entered(body):
	is_vision_area_empty = false

func _on_VisionArea_body_exited(body):
	if find_targets_in_area(["player"], $VisionArea).size() == 0:
		is_vision_area_empty = true

func _on_Hurtbox_area_entered(area):
	var areaParent = area.owner
	if "is_projectile" in area:
		areaParent = area
	take_damage(areaParent)

func _on_EngageRange_body_entered(body):
	allow_attack = true

func _on_EngageRange_body_exited(body):
	allow_attack = false
