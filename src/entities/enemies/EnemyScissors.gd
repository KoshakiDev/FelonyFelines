extends "res://src/scripts/enemySimplified.gd"

var hurtParticle = preload("res://HurtParticle.tscn")

var type: String = "scissors"

onready var state_machine := $StatesMachine

onready var vision_area = $VisionArea

onready var health_bar = $HealthBar

onready var anim_player = $AnimPlayer

onready var raycasts = $Raycasts

onready var hit_range = $HitRange

onready var death_sound = $Death

onready var collision = $CollisionShape2D

onready var hit_range2 = $HitRange2

onready var cooldown_timer = $Timer

func _ready():
	pass

func _process(delta):
	if health <= 0:
		state_machine.transition_to("Death")
		
func spawn_particle():
	var effect = hurtParticle.instance()
	get_tree().current_scene.add_child(effect)
	effect.global_position = global_position
