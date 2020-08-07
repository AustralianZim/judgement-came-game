extends HBoxContainer
export (PackedScene) var LetterObject
signal completed(cheated)
signal use_hint
signal harder

var puzzle_text:String
var letters = []
var busy = false
var illegal_letters = ""
var guessed = ""

func _ready() -> void:
	pass

func make_guess(guess:String) -> bool:
	print([guess, puzzle_text])
	
	if busy:
		return
	busy = true
	if guess.to_lower() == puzzle_text.to_lower() \
	or guess == "next":
		for letter in letters:
			letter.fade_in(true)
		yield(get_tree().create_timer(1), "timeout")
		emit_signal("completed", guess == "next")
		busy = false
		return true
	
	busy = false
	return false # wrong guess

func reveal_letter(letter:String, emit:bool = false) -> int:
	if len(letter) != 1:
		return -1
	
	#prevent double guessing
	if guessed.find(letter[0]) != -1:
		return -1
	
	if emit:
		emit_signal("use_hint")
	
	var result = 0

	global.Hints.text += letter[0]
	guessed += letter[0]
	
	for i in range(len(puzzle_text)):
		if puzzle_text[i].to_lower() == letter[0].to_lower():
			letters[i].fade_in()
			result += 1
	
	return result # Number of occurrances of letter

func clear_all() -> void:
	for child in letters:
		child.queue_free()
	letters.clear()

func next_puzzle(text, illegals) -> void:
	clear_all()
	if illegals != "":
		emit_signal("harder")
	yield(get_tree().create_timer(1), "timeout")
	global.Hints.text = ""
	guessed = ""
	puzzle_text = text
	illegal_letters = illegals
	
	for i in range(len(puzzle_text)):
		var letter = LetterObject.instance()
		letter.text = puzzle_text[i]
		var illegal = illegal_letters.find(letter.text)+1
		if illegal > 0:
			letter.illegal = true
			letter.colorcode = illegal
		letters.append(letter)
		add_child(letter)
	
	reveal_letter(puzzle_text[0])
