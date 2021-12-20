extends "res://src/entities/entityModules.gd"

export var type: String = "rock"

export var max_steering: float = 2.5

export var bullet_speed = 400

onready var state_machine := $StateMachine


onready var sprite := $Sprite

onready var health_bar := $HealthBar

onready var animation_machine := $AnimationMachine


onready var hurtbox = $Hurtbox
onready var engage_range := $EngageRange
onready var vision_area := $VisionArea

onready var pellets := $Pellets

onready var bullet_spawner = $BulletSpawner


func _ready():
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	vision_area.connect("body_entered", self, "_on_VisionArea_body_entered")
	vision_area.connect("body_exited", self, "_on_VisionArea_body_exited")
	engage_range.connect("body_entered", self, "_on_EngageRange_body_entered")
	engage_range.connect("body_exited", self, "_on_EngageRange_body_exited")

func _process(delta):
	pass
