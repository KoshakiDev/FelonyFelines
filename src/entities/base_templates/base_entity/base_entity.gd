#BASE CLASS FOR ALL ENTITIES
extends KinematicBody2D 
class_name Entity

"""
Functionality:
	- Name
	- Type
	- Health
	- Movement
	- Sprite direction
	- Plays animations
	- Plays sound
"""
export var entity_name = "NAME"
export var entity_type = "TYPE"

onready var health_manager = $HealthManager
onready var movement = $Movement

onready var animation_machine = $AnimationMachine
onready var state_machine = $StateMachine
onready var sound_machine = $SoundMachine
onready var listener = $Listener2D

#Physics Variables
onready var physics_collider = $PhysicsCollider

#Visual Variables
onready var visuals = $Visuals
onready var sprite = $Visuals/Sprite
const hit_effect = preload("res://src/components/hit/HitEffect.tscn")


#Area Variables
onready var hurtbox = $Areas/Hurtbox
var can_get_hit = true

#Healthbar
onready var health_bar = $HealthBar/HealthBarVisual

#Navigation
onready var nav_agent = $NavigationAgent2D

#Debug Variables
var line2d: Line2D

func _ready():
	if $Debug.has_node("Line2D"):
		line2d = $Debug/Line2D
	health_manager.connect("health_changed", health_bar, "set_value")
	health_manager.connect("max_health_changed", health_bar, "set_max")
	health_manager.emit_signal("max_health_changed", health_manager.max_health)
	health_manager.emit_signal("health_changed", health_manager.health)

	hurtbox.connect("area_entered", self, "hurt")

func _physics_process(delta):
	if movement.vector_to_movement_direction(movement.get_intended_velocity()).x != 0:
		visuals.scale.x = movement.vector_to_movement_direction(movement.get_intended_velocity()).x
	move_and_slide(movement.get_actual_velocity())

func hurt(attacker_area):
	if health_manager.is_dead() or !can_get_hit:
		return
	var knockback_direction = global_position - attacker_area.global_position
	movement.apply_knockback(knockback_direction, attacker_area.knockback_value)
	health_manager.take_damage(attacker_area.damage_value)
	create_hit_effect()
	sound_machine.play_sound("Damage")
	
	if state_machine.has_node("Pain"):
		if (knockback_direction.x > 0 and visuals.scale.x > 0) or (knockback_direction.x < 0 and visuals.scale.x < 0):
			state_machine.transition_to("Pain", {Back = true})
		elif (knockback_direction.x > 0 and visuals.scale.x < 0) or (knockback_direction.x < 0 and visuals.scale.x > 0):
			state_machine.transition_to("Pain", {Front = true})
	
	

func turn_off_all():
	hurtbox.monitorable = false
	hurtbox.monitoring = false

func turn_on_all():
	hurtbox.monitorable = true
	hurtbox.monitoring = true

"""
The effect must be created by an Effect Manager from the world, not from the entity
"""
# There must be a better way to make this
func create_hit_effect():
	var effect = hit_effect.instance()
	Global.misc.add_child(effect)
	effect.global_position = global_position
	

#Kept in because of ease of use
func play_animation(animation, node_name):
	animation_machine.play_animation(animation, node_name)

func set_animation(duration, node_name):
	animation_machine.set_animation(duration, node_name)

func get_animation(animation, node_name):
	return animation_machine.get_animation(animation, node_name)

func get_animation_player(animation_player_name):
	return animation_machine.get_node(animation_player_name)

