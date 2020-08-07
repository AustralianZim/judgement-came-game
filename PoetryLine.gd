extends Label

var hidden = true
var verse:String
var buffer_text:String
var illegals:String
var current = false

func _ready() -> void:
	for letter in verse:
		text += '.'
	
	add_font_override("font", load("res://Fonts/sub-text-2.tres"))
	add_color_override("font_color", Color(1, 1, 1, 0.4))
	align = ALIGN_CENTER

func reveal() -> void:
	text = verse % buffer_text

func select(hidden:bool = true) -> void:
	current = true
	add_font_override("font", load("res://Fonts/heading-3.tres"))
	
	var hidden_text = ""
	for letter in buffer_text:
		if letter == " ":
			hidden_text += " "
		else:
			hidden_text += "_"
	if text != "":
		if hidden:
			text = verse % hidden_text
		else:
			text = verse % buffer_text
	$Anim.current_animation = "fade_in"
	$Anim.play()

func deselect() -> void:
	current = false
	$Anim.current_animation = "fade_out"
	$Anim.play()

func _animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		add_font_override("font", load("res://Fonts/sub-text-2.tres"))
		add_color_override("font_color", Color(1, 1, 1, 0.4))
