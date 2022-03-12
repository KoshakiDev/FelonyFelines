extends Node2D

onready var label = $RichTextLabel

func update_ammo_bar(ammo_count):
	if ammo_count > 0:
		label.set_text(str(ammo_count))
		visible = true
	else:
		visible = false
