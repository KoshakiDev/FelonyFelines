extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn_transparent_area = $TurnTransparent

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_transparent_area.connect("body_entered", self, "turn_transparent")
	turn_transparent_area.connect("body_exited", self, "turn_opaque")

func turn_transparent(body):
	modulate.a /= 2
	
func turn_opaque(body):
	modulate.a *= 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
