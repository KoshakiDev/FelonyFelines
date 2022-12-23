extends NavigationAgent2D

onready var update_path_timer = $UpdatePathTimer
var can_update_path = true

func _ready():
	update_path_timer.connect("timeout", self, "update_path")
	

func update_path():
	can_update_path = true
