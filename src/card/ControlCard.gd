extends Sprite



func show_card():
	set_frame(0)
	
func extract_card():
	set_frame(1)

func insert_card():
	set_frame(2)

func hide_card():
	set_frame(3)


func _on_ControlCard_frame_changed():
	pass
