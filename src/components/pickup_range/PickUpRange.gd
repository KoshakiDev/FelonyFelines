extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("Animate")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
