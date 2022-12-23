extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var interact_front = $InteractFront
onready var interact_back = $InteractBack

onready var door_collider = $Door

# Called when the node enters the scene tree for the first time.
func _ready():
	interact_back.connect("body_entered", self, "open")
	interact_front.connect("body_entered", self, "open")
	interact_back.connect("body_exited", self, "close")
	interact_front.connect("body_exited", self, "close")
	

func close(body):
	door_collider.disabled = false
	$Sprite.frame = 0


func open(body):
	door_collider.disabled = true
	$Sprite.frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
