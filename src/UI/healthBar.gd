extends TextureProgress

#THIS ONLY CONTROLS THE REPRESENTATION, THERE IS ALSO HEALTH IN THE ENTITY MODULE

onready var tween = $Tween
onready var animation_player = $AnimationPlayer

export(Gradient) var gradient

func _ready():
	tint_progress = gradient.interpolate(ratio)

func _on_value_changed(new_value):
	tint_progress = gradient.interpolate(ratio)

func set_value(new_value):
	animation_player.play("twinkle")
	var duration = animation_player.current_animation_length
	tween.interpolate_property(self, "value", value, new_value, duration, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
