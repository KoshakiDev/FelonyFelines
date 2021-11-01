extends KinematicBody2D

class_name PlayerCharlieOverworldMode

var velocity

export var run_speed = 1000

onready var fsm := $StatesMachine
onready var label := $Label

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var attack_sprite = $AttackSprite
onready var control_card = $Sprite/ControlCard

onready var chipText = $ChipText

onready var enemyDetector = $EnemyDetector

func _ready():
	attack_sprite.frame = 0
	ready_card()

func ready_card():
	if Chip.is_with_charlie:
		control_card.show_card()
	else:
		control_card.hide_card()

func _process(_delta: float) -> void:
	if enemyDetector.get_overlapping_bodies().size() > 0:
		var target
		for i in enemyDetector.get_overlapping_bodies():
			target = i
			break
		if Chip.is_with_charlie == true:
			chipText.bbcode_text = "[center]Insert Chip?[/center]"
			target.control_card.insert_card()
		elif Chip.is_with_charlie == false and target.get_is_controlled() == true:
			chipText.bbcode_text = "[center]Extract Chip?[/center]"
			target.control_card.extract_card()
	else:
		chipText.bbcode_text = ""
