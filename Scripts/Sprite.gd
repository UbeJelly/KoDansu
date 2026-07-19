extends TextureRect


func _on_mouse_entered() -> void:
	$Konata.emit_signal("mouse_entered")


func _on_mouse_exited() -> void:
	$Konata.emit_signal("mouse_exited")
