extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("update_alarm_count", self, "update_alarm_count")

func update_alarm_count():
	var children = get_children()
	for i in range(0, min(Global.alarm_counter, 5)):
		children[i].frame = 1
