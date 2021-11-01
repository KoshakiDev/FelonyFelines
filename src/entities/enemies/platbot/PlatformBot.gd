extends KinematicBody2D

class_name PlatformBot

var velocity

export var is_controlled = false
export var has_gun = true

export var walk_speed = 500
export var gravity = 3500
export var jump_impulse = 1200

onready var fsm := $StatesMachine
onready var label := $Label
onready var dashTimer = $DashTimer
onready var idleTimer = $IdleTimer
onready var walkTimer = $WalkTimer
onready var hitbox = $HitBox
onready var animationPlayer = $AnimationPlayer
onready var armAnimation = $ArmAnimation
onready var sprite = $Sprite
onready var armController = $ArmController
onready var gunSprite = $ArmController/ArmFront/GunSprite
onready var attackTrigger = $AttackTrigger
onready var attackRay1 = $AttackTrigger/AttackRay1
onready var attackRay2 = $AttackTrigger/AttackRay2
onready var control_card = $ControlCard

signal become_controlled

func _ready():
	if !has_gun:
		gunSprite.visible = false

func _process(_delta: float) -> void:
	label.text = fsm.state.name

func get_is_controlled():
	return is_controlled 

func attack():
	if attackTrigger.are_rays_colliding() and !has_gun:
		var follow_direction
		if attackTrigger.get_colliding_rays() == "AttackRay1":
			follow_direction = attackRay1.scale.y
		if attackTrigger.get_colliding_rays() == "AttackRay2":
			follow_direction = attackRay2.scale.y
		fsm.transition_to("MeleeAttack", {direction=follow_direction})
	elif attackTrigger.are_rays_colliding() and has_gun:
		var knockback_direction
		if attackTrigger.get_colliding_rays() == "AttackRay1" and attackRay1.scale.y == sprite.scale.x:
			knockback_direction = attackRay1.scale.y
		if attackTrigger.get_colliding_rays() == "AttackRay2" and attackRay2.scale.y == sprite.scale.x:
			knockback_direction = attackRay2.scale.y
		if knockback_direction != null:
			fsm.transition_to("Shoot", {direction=knockback_direction})

func _on_Platbot_become_controlled():
	if is_controlled == false and Chip.is_with_charlie == true:
		is_controlled = true
		Chip.is_with_charlie = false
	elif is_controlled == true and Chip.is_with_charlie == false:
		is_controlled = false
		Chip.is_with_charlie = true
		


func _on_WalkTimer_timeout():
	fsm.transition_to("Idle")

func _on_IdleTimer_timeout():
	fsm.transition_to("Walk")
