extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var switch_timer = $SwitchTimer
onready var animation_player = $AnimationPlayer
onready var vision_area = $VisionArea

func _ready():
	switch_timer.connect("timeout", self, "switch_view")
	switch_timer.start()	
	vision_area.connect("begin_suspicion", self, "begin_suspicion")	
	vision_area.connect("target_detected", self, "target_detected")
	vision_area.connect("target_lost", self, "target_lost")
	animation_player.play("Normal")

func begin_suspicion():
	animation_player.play("Suspicion")

func target_detected(target):
	animation_player.play("Detected")

func target_lost():
	animation_player.play("Normal")


func _physics_process(delta):
	pass
	
func switch_view():
	scale.x *= -1
	switch_timer.start()

