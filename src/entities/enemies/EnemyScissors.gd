extends "res://src/entities/entityModules.gd"

export var type: String = "scissors"

export var max_steering: float = 2.5

onready var state_machine := $StateMachine

onready var vision_area := $VisionArea

onready var health_bar := $HealthBar

onready var animation_machine := $AnimationMachine

onready var hitbox := $Hitbox

onready var engage_range := $EngageRange

onready var collision := $CollisionShape2D

onready var sprite := $Sprite

export var damage_value: float = 10
export var knockback_value: float = 20

onready var hurtbox = $Hurtbox

func _ready():
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	vision_area.connect("area_entered", self, "_on_VisionArea_area_entered")
	vision_area.connect("area_exited", self, "_on_VisionArea_area_exited")


func _process(delta):
	pass
