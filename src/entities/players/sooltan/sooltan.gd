extends KinematicBody2D

var velocity

export var run_speed = 1000

onready var state_machine := $StatesMachine
onready var label := $Label

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var attack_sprite = $AttackSprite
#onready var control_card = $Sprite/ControlCard

onready var animation_tree = $AnimationTree
onready var hand_pos_anim_tree = $HandPosAnimTree

onready var chipText = $ChipText

onready var enemyDetector = $EnemyDetector

onready var weapon_manager = $WeaponManager

func _ready():
	#ready_card()
	pass

#func ready_card():
#	if Chip.is_with_charlie:
#		control_card.show_card()
#	else:
#		control_card.hide_card()

func _input(event):
	if event.is_action_pressed("next_weapon_2"):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon_2"):
		weapon_manager.switch_to_prev_weapon()

func play_animation(animation):
	animation_tree.get("parameters/playback").travel(animation)

func adjust_blend_position(input_direction):
	animation_tree.set("parameters/Idle/blend_position", input_direction)
	animation_tree.set("parameters/Run/blend_position", input_direction)

func _process(_delta: float) -> void:
	#print(weapon_manager.cur_slot)
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
