extends CanvasLayer

onready var info_pos

onready var info_text = $Info

func _ready():
	Global.set("UI_layer", self)
	Global.main.update_wave()

func update_board():
	#print(Global.points)
#	info_text.bbcode_text = "[center]WAVE: " + str(wave_num) + "[/center]\n[center]POINTS: " + str(points) + "[/center]\n[center]LEFT: " + str(enemy_count) + "[/center]"
	info_text.bbcode_text = "[wave amp=10 freq=2][color=black]WAVE: %s \nPOINTS: %s \nLEFT: %s" % [str(Global.wave_num), str(Global.points), str(Global.enemy_count)]
