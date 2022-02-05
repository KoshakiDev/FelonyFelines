extends Node2D

func _on_Area2D_body_entered(body):
	body.is_inside_friction_area = true
	print('body entered')




func _on_Area2D_body_exited(body):
	body.is_inside_friction_area = false
	print('body exited')
