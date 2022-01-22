extends "res://src/entities/entityModules.gd"

export var bullet_speed = 400

onready var state_machine := $StateMachine


onready var sprite := $Sprite

onready var health_bar := $HealthBar

onready var animation_machine := $AnimationMachine


onready var hurtbox = $Hurtbox
onready var engage_range := $EngageRange

onready var pellets := $Pellets

onready var bullet_spawner = $Sprite/Shoulder1/Cannon/BulletSpawner

onready var cannon = $Sprite/Shoulder1/Cannon


var pseudo_rotation: float = 0
var rotation_speed = 8


func _ready():
	_initialize_health_bar(health_bar)
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	engage_range.connect("body_entered", self, "_on_EngageRange_body_entered")
	engage_range.connect("body_exited", self, "_on_EngageRange_body_exited")
