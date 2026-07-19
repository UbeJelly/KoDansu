extends CanvasLayer


func _on_link_clicked(meta: Variant) -> void:
	OS.shell_open(meta)


func _on_hide_pressed() -> void:
	visible = false
