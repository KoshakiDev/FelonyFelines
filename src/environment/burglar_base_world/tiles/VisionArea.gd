extends Area2D

onready var suspicion_timer = $SuspicionTimer

var target = null

var timer_started = false
var timer_finished = false
var tick_alarm_once = false

signal target_detected(target)
signal begin_suspicion
signal target_lost

export var normal_color = Color(0, 1, 0, 0.74902)
export var suspicion_color = Color(1, 0.796078, 0, 0.74902)
export var detected_color = Color(1, 0, 0, 0.74902)

func _ready():
	connect("body_entered", self, "target_entered_vision_area")
	connect("body_exited", self, "target_exited_vision_area")
	suspicion_timer.one_shot = true
	suspicion_timer.connect("timeout", self, "timeout")
	reset_to_normal()

func reset_to_normal():
	timer_started = false
	timer_finished = false
	tick_alarm_once = false
	modulate = normal_color
	suspicion_timer.stop()

func _physics_process(delta):
	if target == null:
		return
	if target.is_hidden:
		emit_signal("target_lost")
		reset_to_normal()
		return
	if !target.is_hidden && !timer_started:
		timer_started = true
		suspicion_timer.start()
		modulate = suspicion_color
		emit_signal("begin_suspicion")
		#print("suspicion")
	if !target.is_hidden && timer_finished:
		#print("target detected")
		modulate = detected_color
		if !tick_alarm_once:
			Global.alarm_counter += 1
			Global.emit_signal("update_alarm_count")
			tick_alarm_once = true
		emit_signal("target_detected", target)
	

func target_entered_vision_area(body):
	target = body

func target_exited_vision_area(body):
	target = null
	reset_to_normal()
	emit_signal("target_lost")
	#print("target lost")

func timeout():
	timer_finished = true
	
