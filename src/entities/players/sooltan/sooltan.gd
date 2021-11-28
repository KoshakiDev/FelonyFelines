extends KinematicBody2D

var velocity: Vector2

export var player_id = ""
export var run_speed = 1000

onready var state_machine := $StatesMachine
onready var label := $Label

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

onready var animation_tree = $AnimationTree

onready var chipText = $ChipText

onready var enemyDetector = $EnemyDetector

onready var weapon_manager = $WeaponManager

onready var debug_label = $debug

func _ready():
	pass

func enemies_detection_system():
	var bodies = enemyDetector.get_overlapping_bodies()
	var result = []
	for body in bodies:
		if body.is_in_group("enemy"):
			result.append(body)
	return result

func _input(event):
	if event.is_action_pressed("next_weapon_2"):
		weapon_manager.switch_to_next_weapon()
	if event.is_action_pressed("prev_weapon_2"):
		weapon_manager.switch_to_prev_weapon()
	if event.is_action_pressed("action_2"):
		weapon_manager.cur_weapon.action()
		pass

func play_animation(animation):
	animation_tree.get("parameters/playback").travel(animation)

func adjust_blend_position(input_direction):
	animation_tree.set("parameters/Idle/blend_position", input_direction)
	animation_tree.set("parameters/Run/blend_position", input_direction)

func _process(_delta: float) -> void:
	
	pass
#	var enemy = enemies_detection_system()
#	if enemy != false:
##		if Chip.is_with_charlie == true:
##			chipText.bbcode_text = "[center]Insert Chip?[/center]"
##			enemy.control_card.insert_card()
##		elif Chip.is_with_charlie == false and enemy.is_controlled() == true:
##			chipText.bbcode_text = "[center]Extract Chip?[/center]"
##			enemy.control_card.extract_card()
#	else:
#		chipText.bbcode_text = ""
