extends "res://src/entities/players/sooltan/sooltan.gd"


func _ready():
	pass

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
