extends KinematicBody


onready var movement = $Movement
onready var state_machine = $StateMachine

func _ready():
	movement.init(self)
	state_machine.init(self)
