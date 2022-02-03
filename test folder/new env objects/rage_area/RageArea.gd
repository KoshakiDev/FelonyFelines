extends "res://test folder/new env objects/BaseObject.gd"


onready var timer = $Timer

var is_timer_off = true

var entered_body = null

func _on_Area_body_entered(body):
	if !is_timer_off: 
		print("area off limits")
		return
	var areaParent = body.owner
	print(body)
	print(areaParent)
	print('area entered')
	entered_body = body
	apply_change(body)
	timer.start()
	is_timer_off = false

func _on_Area_body_exited(body):
	var areaParent = body.owner
	if body == entered_body:
		remove_change(body)
		entered_body = null	
	

func _on_Timer_timeout():
	is_timer_off = true
	print("can enter now")
