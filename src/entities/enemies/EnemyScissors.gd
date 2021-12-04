extends "res://src/scripts/enemy.gd"

var type: String = "scissors"

onready var state_machine := $StatesMachine

onready var vision_area = $Area2D

onready var health_bar = $HealthBar

onready var anim_player = $AnimPlayer

onready var animation_tree = $AnimTree

onready var raycasts = $Raycasts

onready var hit_range = $HitRange

func _ready():
	$Sprite.material.set_shader_param("is_control", false)