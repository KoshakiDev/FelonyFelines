extends Sprite

onready var animation_player := $AnimationPlayer


func _ready() -> void:
	animation_player.play("animation")

