#BASE CLASS FOR ALL ENTITIES
extends KinematicBody2D 

onready var functions = $Functions
onready var health_manager = $Functions/HealthManager
onready var sprite_dir_manager = $Functions/SpriteDirectionManager

onready var animation_machine = $AnimationMachine
onready var state_machine = $StateMachine
onready var sound_machine = $SoundMachine

export var entity_name = "NAME"
export var entity_type = "TYPE"

#Physics Variables
export var max_speed: float = 225
var actual_velocity: Vector2
var intended_velocity: Vector2
var knockback: Vector2

var extra_resistance = 0.3
var is_extra_resistance_on = false

var movement_direction: Vector2 = Vector2.ZERO
onready var physics_collider = $PhysicsCollider

#Visual Variables
onready var sprite = $Visuals/Sprite
const hit_effect = preload("res://src/components/hit/HitEffect.tscn")


#Area Variables
onready var hurtbox = $Areas/Hurtbox
onready var hurtbox_shape = $Areas/Hurtbox/HurtboxShape
var can_get_hit = true

#Healthbar
onready var healthbar = $HealthBar/HealthBarVisual

#Debug Variables
var line2d: Line2D


#SOUNDS
onready var damage_sound = $SoundMachine/Damage
onready var pain_sound = $SoundMachine/Pain
onready var death_sound = $SoundMachine/Death
onready var footstep_sound = $SoundMachine/Footstep


func _ready():
	if $Debug.has_node("Line2D"):
		line2d = $Debug/Line2D
	health_manager._initialize_health_bar(healthbar)
	health_manager.set_health(health_manager.health)
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")

func move(force: Vector2):
	var force_direction = force.normalized()
	intended_velocity = intended_velocity.linear_interpolate(force_direction * max_speed, Global.ACCEL)
	
func _physics_process(delta):
	if line2d != null:
		line2d.global_position = Vector2.ZERO
		
	actual_velocity = intended_velocity + knockback
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	intended_velocity = intended_velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION + extra_resistance * int(is_extra_resistance_on))
	if not (is_equal_approx(intended_velocity.x, 0.0) and is_equal_approx(intended_velocity.y, 0.0)):
		sprite_dir_manager.adjust_direction(intended_velocity)
	move_and_slide(actual_velocity)


# This is the "hit" function, it can be called in children 
# and add additional code by calling "._on_Hurtbox_area_entered(area)" first
func _on_Hurtbox_area_entered(area):
	if health_manager.is_dead(): return
	if !can_get_hit: return
	var attacker = area.owner
	if area.is_in_group("PROJECTILE"):
		attacker = area
		if attacker.is_player_bullet:
			if entity_type == "PLAYER": 
				return
		elif entity_type == "ENEMY": 
			return
	elif attacker.entity_type == entity_type: # If statement to avoid friendly fire
		return
	var effect = hit_effect.instance()
	Global.misc.add_child(effect)
	effect.global_position = attacker.global_position
	health_manager.take_damage(attacker)
	damage_sound.play()
	#pain_sound.play()
	print("took damage and played sound")
	

#Kept in because of ease of use
func play_animation(animation, node_name):
	animation_machine.play_animation(animation, node_name)

func set_animation(duration, node_name):
	animation_machine.set_animation(duration, node_name)

func get_animation(animation, node_name):
	return animation_machine.get_animation(animation, node_name)

func get_animation_player(animation_player_name):
	return animation_machine.get_node(animation_player_name)
