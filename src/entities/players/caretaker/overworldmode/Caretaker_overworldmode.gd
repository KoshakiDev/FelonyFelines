extends KinematicBody2D

var velocity

export var is_controlled = true

export var run_speed = 1000

onready var fsm := $StatesMachine
onready var label := $Label
onready var legAnimationPlayer = $LegsPlayer
onready var armAnimationPlayer = $ArmsPlayer
onready var torsoAnimationPlayer = $TorsoPlayer
onready var headAnimationPlayer = $HeadPlayer
onready var modulateAnimationPlayer = $ModulatePlayer
onready var whole_body = $Whole
onready var body = $Whole/Body

onready var control_card = $ControlCard

signal become_controlled

func _ready():
	clear_body()
	connect("become_controlled", self, "_on_Caretaker_become_controlled")
	
func _process(_delta: float) -> void:
	label.text = fsm.state.name
	
func get_is_controlled():
	return is_controlled

func clear_body():
	$Whole/Body.position.x = 0
	$Whole/Body.position.y = 0
	$Whole/Body.modulate = Color(1, 1, 1, 1)
	check_children(whole_body)

func check_children(node):
	for i in node.get_children():
		if i.get_class() != "Node2D":
			continue
		i.rotation_degrees = 0
		if i.get_child_count() > 0:
			check_children(i)
	
func _on_Caretaker_become_controlled():
	if is_controlled == false and Chip.is_with_charlie == true:
		is_controlled = true
		Chip.is_with_charlie = false
	elif is_controlled == true and Chip.is_with_charlie == false:
		is_controlled = false
		Chip.is_with_charlie = true
	fsm.transition_to("Off")

func test():
	print("test")
