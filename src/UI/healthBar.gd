extends TextureRect

func _ready():
	$TextureProgress.value = 100

func set_percent_value(value):
	$TextureProgress.value = value
