extends KinematicBody2D 

var velocity: Vector2
var knockback: Vector2

export var max_health: float = 100
var health: float = max_health

func _ready():
	pass

func play_animation(animation):
	self.animation_player.play(animation)

func set_animation(duration):
	self.animation_player.seek(duration, false)

func get_animation(animation):
	return self.animation_player.get_animation(animation)

func adjust_blend_position(input_direction):
	if input_direction.x != 0:
		self.sprite.scale.x = input_direction.x

func damage_area(targetGroups, hit_range, damage_value, knockback_value):
	var targets = find_targets_in_area(targetGroups, hit_range)
	for target in targets:
		target.take_damage(self, damage_value, knockback_value)
	
func find_targets_in_area(target_groups, area):
	var bodies = area.get_overlapping_bodies()
	var targets = []
	for body in bodies:
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

func take_damage(attacker, damage_value, knockback_value):
	play_animation("Hit")
	var new_health = self.health_bar.take_damage(health, max_health, damage_value)

	knockback += (global_position - attacker.global_position).normalized() * knockback_value

	if new_health <= 0:
		self.state_machine.transition_to("Death")
	health = new_health
	return

func heal(heal_value):
	var new_health = self.health_bar.heal(health, max_health, heal_value)
	health = new_health

func _physics_process(delta):
	velocity = velocity + knockback

	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	
	move_and_slide(velocity)
	
	
	
