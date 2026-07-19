extends SubViewport


signal mouse_entered
signal mouse_exited
var tween


func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	$Frames.play()


func _on_mouse_entered() -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().set_parallel(true).bind_node(self)
	tween.tween_method(set_shader_value, $Frames.get_material().get_shader_parameter("outline_thickness"), 2.0, 0.1).set_ease(Tween.EASE_IN)
	tween.tween_method(set_shader_value, $Frames.get_material().get_shader_parameter("outline_color"), Color.WHITE, 0.1).set_ease(Tween.EASE_IN)


func _on_mouse_exited() -> void:
	if tween: tween.kill()
	tween = get_tree().create_tween().set_parallel(true).bind_node(self)
	tween.tween_method(set_shader_value, $Frames.get_material().get_shader_parameter("outline_thickness"), 0.0, 0.1).set_ease(Tween.EASE_IN)
	tween.tween_method(set_shader_value, $Frames.get_material().get_shader_parameter("outline_color"), Color.TRANSPARENT, 0.1).set_ease(Tween.EASE_IN)


func set_shader_value(value: Variant) -> void:
	var param := ""
	if value is float: param = "outline_thickness"
	elif value is Color: param = "outline_color"
	$Frames.get_material().set_shader_parameter(param, value)
