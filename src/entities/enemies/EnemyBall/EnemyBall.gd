extends "res://src/entities/entityModules.gd"

export var type: String = "scissors"

export var max_steering: float = 2.5

onready var state_machine := $StateMachine


onready var health_bar := $HealthBar

onready var animation_machine := $AnimationMachine

onready var hitbox := $Hitbox
onready var engage_range := $EngageRange
onready var vision_area := $VisionArea


onready var collision := $CollisionShape2D

onready var sprite := $Sprite

export var damage_value: float = 10
export var knockback_value: float = 20

onready var hurtbox = $Hurtbox

func _ready():
	hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	vision_area.connect("body_entered", self, "_on_VisionArea_body_entered")
	vision_area.connect("body_exited", self, "_on_VisionArea_body_exited")
	engage_range.connect("body_entered", self, "_on_EngageRange_body_entered")
	engage_range.connect("body_exited", self, "_on_EngageRange_body_exited")


func _process(delta):
	pass

func call_hit():
	if is_dead():
		return
	state_machine.transition_to("Idle")
	velocity = Vector2.ZERO
