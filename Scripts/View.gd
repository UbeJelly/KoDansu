extends Control


const MIN_SIZE := Vector2i(250, 160)
const MAX_SIZE := Vector2i(500, 320)
@onready var dragging := false
@onready var click_xy := Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				click_xy = get_global_mouse_position()
			else:
				dragging = false

		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if get_window().size <= MAX_SIZE:
				get_window().size += Vector2i(10, 10)
				if Engine.is_editor_hint() or OS.is_debug_build():
					print(get_window().get_size())

		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if get_window().size >= MIN_SIZE:
				get_window().size -= Vector2i(10, 10)
				if Engine.is_editor_hint() or OS.is_debug_build():
					print(get_window().get_size())

		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed: $Options.visible = true

	if event is InputEventMouseMotion and dragging == true:
		var new_xy: Vector2i = get_window().get_position() + Vector2i(event.position - click_xy)
		get_window().set_position(new_xy)


func _on_Window_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if $Options.visible == true:
				$Options.visible = false


func _on_set_About_visible() -> void:
	$About.visible = !$About.visible
