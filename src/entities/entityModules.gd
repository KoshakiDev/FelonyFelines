extends KinematicBody2D 

export var entity_name = "NAME"
export var entity_type = "ENTITY"

var velocity: Vector2
var knockback: Vector2

export var max_speed: float = 225
export var max_steering: float = 2.5

export var ITEM_DROP_PERCENT = 50

# Enemy variables
var bodies_in_engage_area = 0


#HEALTH
signal max_health_changed(new_max_health)
signal health_changed(new_health)
signal no_health

export(float) var max_health = 1 setget set_max_health
onready var health = max_health setget set_health

func set_max_health(new_max_health):
	max_health = new_max_health
	max_health = max(1, new_max_health)
	emit_signal("max_health_changed", max_health)

func set_health(new_value):
	health = new_value
	health = clamp(health, 0, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func _ready():
	pass

#this function is called from the entity itself
func _initialize_health_bar(health_bar):
	connect("health_changed", health_bar, "set_value")
	connect("max_health_changed", health_bar, "set_max")
	emit_signal("max_health_changed", max_health)
	emit_signal("health_changed", health)
##HEALTH


func heal(heal_value):
	health += heal_value
	set_health(health)

func take_damage(attacker):
	var damage_value = attacker.damage_value
	var knockback_value = attacker.knockback_value
	var attacker_pos = attacker.global_position

	knockback = (global_position - attacker_pos).normalized() * knockback_value

	health -= damage_value
	set_health(health)
	if is_dead():
		self.state_machine.transition_to("Death")
	return

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


func _physics_process(delta):
	velocity = velocity + knockback
	
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)

	if not (is_equal_approx(velocity.x, 0.0) and is_equal_approx(velocity.y, 0.0)):
		adjust_direction(velocity)
	
	move_and_slide(velocity)
	


func _on_Hurtbox_area_entered(area):
	if is_dead(): return
	
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

	#print(entity_type, attacker)

	take_damage(attacker)

func _on_EngageRange_body_entered(body):
	if not body.is_in_group("PLAYER"): return
	if body.is_dead(): return
	
	bodies_in_engage_area += 1

func _on_EngageRange_body_exited(body):
	if not body.is_in_group("PLAYER"): return
	bodies_in_engage_area -= 1
