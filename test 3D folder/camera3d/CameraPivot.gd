extends Spatial

func _process(delta):
	if Input.is_key_pressed(KEY_RIGHT):
		rotation.y -= Global.ROTATION_SPEED
	if Input.is_key_pressed(KEY_LEFT):
		rotation.y += Global.ROTATION_SPEED
#	if Input.is_key_pressed(KEY_UP):
#		rotation.x = clamp(rotation.x - Global.ROTATION_SPEED, -PI * 2 / 9, 0)
#	if Input.is_key_pressed(KEY_DOWN):
#		rotation.x = clamp(rotation.x + Global.ROTATION_SPEED, -PI * 2 / 9, 0)
	
