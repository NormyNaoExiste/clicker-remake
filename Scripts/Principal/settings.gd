extends Control



func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(640,320))
		1:
			DisplayServer.window_set_size(Vector2i(1280,720))
		2:
			DisplayServer.window_set_size(Vector2i(1600,900))
		3:
			DisplayServer.window_set_size(Vector2i(1920,1080))



func _on_fullscreen_toggled(toggled_on: bool) -> void:
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if toggled_on else Window.MODE_WINDOWED
