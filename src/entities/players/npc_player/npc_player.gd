extends "res://src/entities/players/sooltan/sooltan.gd"


func _ready():
	pass

func _physics_process(delta):
	#Give the boy a target to run to and it will move
	# For now, as an example, it will run towards the cursor 
	# Launch res://test folder/GeneralTestRoom.tscn to see the example
	var target_pos = get_global_mouse_position()
	var vector_to_target = target_pos - global_position
	var input_direction = vector_to_target
	
	npc_move(input_direction)
	if is_equal_approx(input_direction.x, 0.0) and is_equal_approx(input_direction.y, 0.0):
		stop_all_input()
	
func stop_all_input():
	undo("up" + player_id)
	undo("down" + player_id)
	undo("right" + player_id)
	undo("left" + player_id)


# This mimicks button press. Notice, that if you don't undo(), it will 
# act as if you are still holding the button
func do(input):
	var a = InputEventAction.new()
	a.action = input
	a.pressed = true
	Input.parse_input_event(a)

func undo(input):
	var a = InputEventAction.new()
	a.action = input
	a.pressed = false
	Input.parse_input_event(a)


# shorthand for all actions
func npc_action():
	do("action" + player_id)

func npc_switch_to_next_weapon():
	do("next_weapon" + player_id)

func npc_switch_to_prev_weapon(): 
	do("prev_weapon" + player_id)


# it takes in a vector to run to and will mimick 
# the button moves needed to get there
func npc_move(vector):
	if vector.x < 0:
		do("left" + player_id)
		undo("right" + player_id)
	elif vector.x > 0:
		do("right" + player_id)
		undo("left" + player_id)
	elif vector.x == 0:
		undo("right" + player_id)
		undo("left" + player_id)
	if vector.y < 0:
		do("up" + player_id)
		undo("down" + player_id)
	elif vector.y > 0:
		undo("up" + player_id)
		do("down" + player_id)
	elif vector.y == 0:
		undo("up" + player_id)
		undo("down" + player_id)
