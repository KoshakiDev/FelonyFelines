extends KinematicBody2D

var velocity: Vector2
var knockback: Vector2

export var max_health:float = 100
var health:float = max_health

export var player_id = "_2"
export var max_speed = 200

onready var state_machine := $StatesMachine
onready var label := $Label

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

onready var animation_tree = $AnimationTree

onready var chipText = $ChipText

onready var hit_range = $WeaponManager/HandPosition2D/Axe/HitRange

onready var weapon_manager = $WeaponManager

onready var debug_label = $debug

onready var health_bar = $HealthBar

onready var hit

var sprite_texture = preload("res://assets/entities/players/sooltan/sooltan_2.png")
var axe_2_texture = preload("res://assets/entities/players/sooltan/axe_2.png")

func _ready():
	Global.set("sooltan", self)
	
	if player_id == "_2":
		sprite.set_texture(sprite_texture)
		$WeaponManager/HandPosition2D/Axe.set_texture(axe_2_texture)
	pass

func find_targets_in_area(target_groups, area):
	var bodies = area.get_overlapping_bodies()
	var targets = []
	for body in bodies:
		for group in target_groups:
			if body.is_in_group(group):
				targets.append(body)
				break
	return targets

func _input(event):
	if event.is_action_pressed("next_weapon" + player_id):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon" + player_id):
		weapon_manager.switch_to_prev_weapon()
	if event.is_action_pressed("action" + player_id):
		 weapon_manager.cur_weapon.action()
		
func play_animation(animation):
	animation_tree.get("parameters/playback").travel(animation)

func adjust_blend_position(input_direction):
	animation_tree.set("parameters/Idle/blend_position", input_direction)
	animation_tree.set("parameters/Run/blend_position", input_direction)

func take_damage(health, max_health, damage_value):
	$HitAnimationPlayer.play("Hit")
	return $HealthBar.take_damage(health, max_health, damage_value)

func heal(health, max_health, heal_value):
	return $HealthBar.heal(health, max_health, heal_value)

func _physics_process(delta):
	knockback = knockback.linear_interpolate(Vector2.ZERO, Global.FRICTION)
	
	velocity = velocity + knockback
	move_and_slide(velocity)

	velocity = velocity.linear_interpolate(Vector2.ZERO, Global.FRICTION)
