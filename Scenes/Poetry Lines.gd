extends VBoxContainer
export (PackedScene) var line_template
signal next_puzzle(text) # static type?
signal finish_game

var lines = [
	#['First line of the story %s', 'puzzle2'],
	#['White sulfur and %s, destroying the old Earth.', 'fire rained'],
	#['%s and fell on us. Fin.', 'Judgement came']
]
var children = []
var current:int = -1

func _ready() -> void:
	var file = File.new()
	file.open("res://poem.tres", File.READ)
	var file_line = file.get_csv_line("|")
	while (file_line[0] == "" or file_line[0][0] != "#"):
		if file_line[0] == "":
			lines.append(["","",""])
		else:
			lines.append(file_line)
		
		file_line = file.get_csv_line("|")

	# add a top padding
	for i in range(4):
		add_child(line_template.instance())
	
	for line in lines:
		var label = line_template.instance()
		label.verse = line[0]
		label.buffer_text = line[1]
		label.illegals = line[2]
		children.append(label)
		add_child(label)
	
	# add a bottom padding
	for i in range(4):
		add_child(line_template.instance())
	
	current = len(children) - 1
	children[current].select()
	emit_signal("next_puzzle", children[current].buffer_text, children[current].illegals)

func select_all() -> void:
	for child in children:
		child.select(false)

func completed(cheated:bool) -> void:
	if current < 0:
		emit_signal("finish_game")
		return
	
	children[current].reveal()
	children[current].deselect()
	current -= 1
	while children[current].verse == "":
		current -= 1
	if current < 0:
		emit_signal("finish_game")
		return
	children[current].select()
	emit_signal("next_puzzle", children[current].buffer_text, children[current].illegals)
