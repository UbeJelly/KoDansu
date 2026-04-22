class_name MainWindow extends Control


var dragging: bool = false
var click_xy: Vector2 = Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				dragging = true
				click_xy = get_global_mouse_position()
			else:
				dragging = false

		if event.button_index == BUTTON_WHEEL_UP:
			OS.window_size += Vector2(10, 10)
			print(OS.get_window_size())
		if event.button_index == BUTTON_WHEEL_DOWN:
			if OS.window_size >= Vector2(240, 150):
				OS.window_size -= Vector2(10, 10)

		if event.button_index == BUTTON_RIGHT:
			if event.pressed:
				$Options.visible = true

	if event is InputEventMouseMotion and dragging == true:
		var new_xy: Vector2 = OS.get_window_position() + (event.position - click_xy)
		OS.set_window_position(new_xy)


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


func _notification(what) -> void:
	match what:
		NOTIFICATION_WM_MOUSE_ENTER:
			mouse_default_cursor_shape = Control.CURSOR_MOVE
		NOTIFICATION_WM_MOUSE_EXIT:
			pass
