extends KinematicBody2D 

export var entity_name = "NAME"
export var entity_type = "ENTITY"

var velocity: Vector2
var knockback: Vector2
var movement_direction: Vector2

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
	if health > new_value:
		play_animation("Hit", "Hit")
	health = new_value
	health = clamp(health, 0, max_health)
	emit_signal("health_changed", health)
	if is_dead():
		self.state_machine.transition_to("Death")
		emit_signal("no_health")




func _ready():
	#navigation = Global.navigation
	line2d = $Line2D
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
	set_health(health-damage_value)
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
#	if direction.x != 0:
#		self.hand_position.scale.y = direction.x
	#self.tween.interpolate_property(self.hand_position, "position", self.hand_position.position, self.hand_position.global_position + direction, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#self.tween.start()
	#print(self.hand_position.global_position + direction)
	self.hand_position.look_at(self.hand_position.global_position + direction)


func return_travel_direction(vector):
	var x_direction = 1
	var y_direction = 1
	var max_speed = vector.length()
	if max_speed != 0:
		x_direction = stepify(vector.x / max_speed, 1)
		y_direction = stepify(vector.y / max_speed, 1)
	return Vector2(x_direction, y_direction)

#navigation2d
#var navigation = null #this is set in ready(), see upwards
var path = []
var threshold = 16
var line2d 

# This is what moves the target towards the path
# It basically iterates an array of several positions which needs to be walked to
func get_next_direction_to_target():
	#print(global_position.distance_to(path[0]), " ", threshold)
	# This "if" checks if the next position has been reached, which then removes it
	if global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	# Otherwise, it continues moving towards a point
	var direction = global_position.direction_to(path[0])
	return direction
		#velocity = direction * max_speed
		#velocity = move_and_slide(velocity)

# get target path receives a position to walk to which adds to the path array
func get_target_path(target_position):
	path = Global.navigation.get_simple_path(global_position, target_position, false)
	line2d.points = path
#navigation2d

func _physics_process(delta):
	# Ok, so this needs to be in a physics process (like in a move state or smth)
	# Mansoor, this basically checks if there is a path to walk to
	if line2d != null:
		line2d.global_position = Vector2.ZERO
#	if path.size() > 0:
#		move_to_target()
	
	velocity = velocity + knockback
	
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	
	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)	
	if not (is_equal_approx(movement_direction.x, 0.0) and is_equal_approx(movement_direction.y, 0.0)):
		adjust_direction(movement_direction)
	
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
	#play_animation("Hit", "Hit")
	take_damage(attacker)

func _on_EngageRange_body_entered(body):
	if not body.is_in_group("PLAYER"): return
	if body.is_dead(): return
	
	bodies_in_engage_area += 1

func _on_EngageRange_body_exited(body):
	if not body.is_in_group("PLAYER"): return
	bodies_in_engage_area -= 1

func _on_EngageRange_enemy_entered(body):
	var enemy_names = ["BALL", "GUNNER", "IMP"]
	if not body.is_in_group("ENTITY"): return
	if not body.entity_name in enemy_names: return
	
	bodies_in_engage_area += 1

func _on_EngageRange_enemy_exited(body):
	var enemy_names = ["BALL", "GUNNER", "IMP"]
	if not body.is_in_group("ENTITY"): return
	if not body.entity_name in enemy_names: return
	
	bodies_in_engage_area -= 1
