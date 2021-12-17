extends "res://src/entities/entityModules.gd"

export var max_speed: int = 50
export var max_steering: float = 2.5

export var type: String = "paper"

onready var state_machine := $StateMachine

onready var vision_area = $VisionArea

onready var health_bar = $HealthBar

onready var anim_player = $AnimationPlayer

onready var hit_range = $HitRange

func _ready():
	pass

func _process(delta):
	pass
