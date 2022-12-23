extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "in_shadow")
	connect("body_exited", self, "out_shadow")

func _physics_process(delta):
	if target == null:
		return
	target.is_hidden = true


func in_shadow(body):
	target = body
	target.is_hidden = true

func out_shadow(body):
	target.is_hidden = false
	target = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
