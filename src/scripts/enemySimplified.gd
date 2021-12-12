extends KinematicBody2D 

var velocity: Vector2
var knockback: Vector2

var is_moving = false

export var max_health: float = 100
var health: float = max_health

export var player_id: String = "_1"

export var max_speed: int = 50
export var max_steering: float = 2.5

func _ready():
	pass

func damage_area(targetGroups, hit_range, damage_value, knockback_value):
	var targets = find_targets_in_area(targetGroups, hit_range)
	for target in targets:
		target.health = target.take_damage(target.health, target.max_health, damage_value)
		target.knockback = (target.global_position - global_position).normalized() * knockback_value

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
	
func play_animation(animation):
	$AnimPlayer.play(animation)

func set_animation(duration):
	$AnimPlayer.seek(duration, false)

func get_animation(animation):
	return $AnimPlayer.get_animation(animation)

func adjust_blend_position(input_direction):
	if input_direction.x != 0:
		$Sprite.scale.x = input_direction.x

func take_damage(health, max_health, damage_value):
#	self.hit_anim_player.play("Hit")
	$HitAnimationPlayer.play("Hit")
	var new_health = $HealthBar.take_damage(health, max_health, damage_value)
	if new_health <= 0:
		$StatesMachine.transition_to("Death")
	return new_health

func _physics_process(delta):
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	velocity = velocity + knockback
	
	move_and_slide(velocity)
	
	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)

	
