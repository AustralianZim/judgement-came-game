extends ScrollContainer

var scrolling = true

func _process(delta: float) -> void:
	if scrolling:
		scroll_vertical = 9000
		scrolling = false
