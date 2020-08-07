extends Button

export (String) var scene_path

# note, this needs to be connected to the _button_up() signal
func _button_up() -> void:
	get_tree().change_scene(scene_path)
