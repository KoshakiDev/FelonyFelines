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

#Area Variables
onready var hurtbox = $Areas/Hurtbox
onready var hurtbox_shape = $Areas/Hurtbox/HurtboxShape

#Healthbar
onready var healthbar = $HealthBar/HealthBarVisual

#Debug Variables
onready var line2d = $Debug/Line2D


func _ready():
	health_manager._initialize_health_bar(healthbar)
	health_manager.set_health(health_manager.health)
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")

func move(direction):
	intended_velocity = intended_velocity.linear_interpolate(direction * max_speed, Global.ACCEL)
	
func _physics_process(delta):
	if line2d != null:
		line2d.global_position = Vector2.ZERO
		
	actual_velocity = intended_velocity + knockback
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	intended_velocity = intended_velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION + extra_resistance * int(is_extra_resistance_on))
	if not (is_equal_approx(intended_velocity.x, 0.0) and is_equal_approx(intended_velocity.y, 0.0)):
		sprite_dir_manager.adjust_direction(intended_velocity)
	move_and_slide(actual_velocity)
	
func _on_Hurtbox_area_entered(area):
	if health_manager.is_dead(): return
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

	if entity_type == "PLAYER":
		Shake.shake(4.0, .5)
	health_manager.take_damage(attacker)

#Kept in because of ease of use
func play_animation(animation, node_name):
	animation_machine.play_animation(animation, node_name)

func set_animation(duration, node_name):
	animation_machine.set_animation(duration, node_name)

func get_animation(animation, node_name):
	return animation_machine.get_animation(animation, node_name)

func get_animation_player(animation_player_name):
	return animation_machine.get_node(animation_player_name)
