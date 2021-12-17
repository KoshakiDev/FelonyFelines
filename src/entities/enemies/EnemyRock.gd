extends "res://src/entities/entityModules.gd"

export var type: String = "rock"

export var max_speed: int = 50
export var max_steering: float = 2.5

onready var state_machine := $StateMachine

onready var vision_area := $VisionArea

onready var sprite := $Sprite

onready var health_bar := $HealthBar

onready var animation_player := $AnimationPlayer

onready var hit_range := $HitRange

onready var pellets := $Pellets

func _ready():
	pass

func _process(delta):
	pass
