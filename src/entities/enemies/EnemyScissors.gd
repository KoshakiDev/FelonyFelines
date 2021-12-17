extends "res://src/entities/entityModules.gd"

export var type: String = "scissors"

export var max_speed: int = 50
export var max_steering: float = 2.5

onready var state_machine := $StateMachine

onready var vision_area = $VisionArea

onready var health_bar = $HealthBar

onready var animation_player = $AnimPlayer

onready var hit_range = $HitRange

onready var collision = $CollisionShape2D

onready var hit_range2 = $HitRange2

func _ready():
	pass

func _process(delta):
	pass
