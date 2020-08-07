extends LineEdit


func clear_all(text:String) -> void:
	$enter.play()
	print(text)
	clear()

func _on_text_changed(new_text: String) -> void:
	if new_text != "":
		$sfx.play()
