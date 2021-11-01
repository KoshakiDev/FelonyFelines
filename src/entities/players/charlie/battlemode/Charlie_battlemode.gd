extends KinematicBody2D 

var velocity

export var run_speed = 1000
export var accel = 100
export var gravity = 3500
export var jump_impulse = 1200

onready var fsm := $StatesMachine
onready var label := $Label

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var attack_sprite = $AttackSprite

onready var chipText = $ChipText

onready var enemyDetector = $EnemyDetector

onready var control_card = $Sprite/ControlCard

func _ready():
	attack_sprite.frame = 0
	ready_card()

func ready_card():
	if Chip.is_with_charlie:
		control_card.show_card()
	else:
		control_card.hide_card()

func _process(_delta: float) -> void:
	if enemyDetector.is_colliding():
		var target = enemyDetector.get_collider()
		if Chip.is_with_charlie == true:
			chipText.bbcode_text = "[center]Insert Chip?[/center]"
			target.control_card.insert_card()
		elif Chip.is_with_charlie == false and target.get_is_controlled() == true:
			chipText.bbcode_text = "[center]Extract Chip?[/center]"
			target.control_card.extract_card()
	else:
		chipText.bbcode_text = ""
