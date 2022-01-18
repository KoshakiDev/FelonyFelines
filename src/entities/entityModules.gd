extends KinematicBody2D 

export var entity_name = "NAME"
export var entity_type = "ENTITY"

var velocity: Vector2
var knockback: Vector2

export var max_health: float = 100
var health: float

export var max_speed: float = 225
export var max_steering: float = 2.5

export var ITEM_DROP_PERCENT = 10

# Enemy variables
var bodies_in_engage_area = 0

func is_dead():
	return is_equal_approx(health, 0)

func play_animation(animation, node_name):
	self.animation_machine.play_animation(animation, node_name)

func set_animation(duration, node_name):
	self.animation_machine.set_animation(duration, node_name)

func get_animation(animation, node_name):
	return self.animation_machine.get_animation(animation, node_name)


func adjust_direction(direction):
	direction = return_travel_direction(direction)
	
	if direction.x != 0:
		self.sprite.scale.x = direction.x

	if "hand_position" in self:
		adjust_hand_rotation(direction)
	
func adjust_hand_rotation(direction):
	if direction.x != 0:
		self.hand_position.scale.y = direction.x
	self.hand_position.look_at(self.hand_position.global_position + direction)

func return_travel_direction(vector):
	var x_direction = 1
	var y_direction = 1
	var max_speed = vector.length()
	if max_speed != 0:
		x_direction = stepify(vector.x / max_speed, 1)
		y_direction = stepify(vector.y / max_speed, 1)
	return Vector2(x_direction, y_direction)

func heal(heal_value):	
	health = min(max_health, health + heal_value)
	self.health_bar.set_percent(health / max_health)

func _physics_process(delta):
	velocity = velocity + knockback
	
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)

	if not (is_equal_approx(velocity.x, 0.0) and is_equal_approx(velocity.y, 0.0)):
		adjust_direction(velocity)
	
	move_and_slide(velocity)
	
func take_damage(attacker):
	var damage_value = attacker.damage_value
	var knockback_value = attacker.knockback_value
	var attacker_pos = attacker.global_position

	knockback = (global_position - attacker_pos).normalized() * knockback_value

	health = max(0, health - damage_value)	
	self.health_bar.set_percent(health / max_health)
	if is_dead():
		self.state_machine.transition_to("Death")

	return

func _on_Hurtbox_area_entered(area):
	var attacker = area.owner
	if "is_projectile" in area:
		attacker = area
		
		if attacker.is_player_bullet:
			if entity_type == "PLAYER": return
		elif entity_type == "ENEMY": return
	elif attacker.entity_type == entity_type: return # If statement to avoid friendly fire

	if self.entity_type == "PLAYER":
		Shake.shake(4.0, .5)
	
	play_animation("Hit", "Hit")	

	print(entity_type, attacker)

	take_damage(attacker)

func _on_EngageRange_body_entered(body):
	if not body.is_in_group("PLAYER"): return
	if body.is_dead(): return
	
	bodies_in_engage_area += 1

func _on_EngageRange_body_exited(body):
	if not body.is_in_group("PLAYER"): return
	bodies_in_engage_area -= 1
