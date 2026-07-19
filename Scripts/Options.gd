extends CanvasLayer


signal set_about_visible


func _on_Minimize_pressed() -> void:
	get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED


func _on_About_pressed() -> void:
	set_about_visible.emit()


func _on_Exit_pressed() -> void:
	get_tree().quit()
