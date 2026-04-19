class_name MainWindow extends Control


var dragging = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				dragging = true
			else:
				dragging = false

		if event.button_index == BUTTON_WHEEL_UP:
			OS.window_size += Vector2(10.0, 10.0)
		if event.button_index == BUTTON_WHEEL_DOWN:
			OS.window_size -= Vector2(10.0, 10.0)

		if event.button_index == BUTTON_RIGHT:
			if event.pressed:
				$Options.visible = true

	if event is InputEventMouseMotion and dragging == true:
		OS.set_window_position(OS.get_window_position() + get_global_mouse_position() - OS.get_window_size() / 2)


func _on_About_meta_clicked(meta) -> void:
	OS.shell_open(meta)


func _on_Hide_pressed() -> void:
	$About.visible = false


func _on_Minimize_pressed() -> void:
	OS.window_minimized = true


func _on_About_pressed() -> void:
	$About.visible = !$About.visible


func _on_Exit_pressed() -> void:
	get_tree().quit()


func _on_Window_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if $Options.visible == true:
				$Options.visible = false
