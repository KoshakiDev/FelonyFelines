extends "res://src/scripts/enemySimplified.gd"

var type: String = "rock"

onready var state_machine := $StatesMachine

onready var vision_area = $Area2D

onready var sprite = $Sprite

onready var health_bar = $HealthBar

onready var anim_player = $AnimPlayer

onready var raycasts = $Raycasts

onready var hit_range = $HitRange

func _ready():
	pass

func _process(delta):
	if health <= 0:
		print(health)
		state_machine.transition_to("Death")
