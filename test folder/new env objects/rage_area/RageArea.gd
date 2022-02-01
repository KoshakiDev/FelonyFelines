extends "res://test folder/new env objects/BaseObject.gd"


onready var timer = $Timer

var is_timer_off = true

func _on_Area_body_entered(body):
	if !is_timer_off: 
		print("area off limits")
		return
	var areaParent = body.owner
	print(body)
	print(areaParent)
	print('area entered')
	apply_change(body)
	timer.start()
	is_timer_off = false

func _on_Area_body_exited(body):
	var areaParent = body.owner
	remove_change(body)


func _on_Timer_timeout():
	is_timer_off = true
	print("can enter now")
