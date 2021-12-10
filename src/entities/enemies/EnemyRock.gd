extends "res://src/scripts/enemySimplified.gd"

var type: String = "rock"

onready var state_machine := $StatesMachine

onready var vision_area = $VisionArea

onready var sprite = $Sprite

onready var health_bar = $HealthBar

onready var anim_player = $AnimPlayer

onready var raycasts = $Raycasts

onready var hit_range = $HitRange

onready var pellets = $Pellets

func _ready():
	pass

func _process(delta):
	pass
