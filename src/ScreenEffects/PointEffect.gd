extends Node2D


const color_variants = [Color.red, Color.aqua, Color.yellow, Color.darkblue]


var autoplay: bool
var points: int
var color: Color


onready var anim_player := $AnimationPlayer
onready var label := $RichTextLabel
onready var back_label := $RichTextLabel2


func _ready() -> void:
	if autoplay:
		show_effect(points, color)

func init(points: int, autoplay := true, color: Color = Color.red) -> void:
	self.points = points
	self.color = color
	self.autoplay = autoplay

func show_effect(points: int, color: Color) -> void:
	#print(points, get_point_string(points))
	var point_string = get_point_string(points)
	label.text = point_string
	back_label.bbcode_text = "[tornado radius=2 freq=10]%s[/tornado]" % point_string
	modulate = color
	anim_player.play("show")

func get_point_string(points: int) -> String:
	return ("+" if points > 0 else "") + str(points)
