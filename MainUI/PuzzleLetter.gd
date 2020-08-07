extends Label

var hidden = true
var illegal = false
var colorcode = 0
var colors = ['ffffff', 'f6645d', 'f6b75d', 'f65da5']

func _ready() -> void:
	if self.text[0] == " ":
		$Underline.visible = false
	else:
		$Underline.visible = true
	
	if illegal:
		$Underline.color = Color(colors[colorcode])

func fade_in(force:bool = false) -> void:
	if illegal and not force:
		return
	if hidden:
		$Anim.current_animation = "fade_in"
		$Anim.play()
		hidden = false
