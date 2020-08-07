extends Panel


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event is InputEventMouseButton:
		hide_self()

func hide_self() -> void:
	visible = false
