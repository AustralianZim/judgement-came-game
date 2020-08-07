extends Control

var tutorial_inc = 0
var stop = false

func _ready() -> void:
	yield(get_tree().create_timer(2), "timeout")
	$Tut_Hint.visible = true

func tutorial(text: String):
	tutorial_inc += 1
	if tutorial_inc == 3:
		$Tut_Bonus.visible = true
	if tutorial_inc == 5:
		$Tut_Guess.visible = true
	if tutorial_inc == 10:
		$Tut_GiveUp.visible = true
	if tutorial_inc == 11:
		$Tut_Final.visible = true

func click() -> void:
	$click.play()

func _on_finish_game() -> void:
	$UI/Puzzle.clear_all()
	yield(get_tree().create_timer(1.5), "timeout")
	$UI/Puzzle.queue_free()
	$UI/Poetry/PoetryLines.select_all()
	yield(get_tree().create_timer(1.5), "timeout")
	$EndScreen.visible = true
	


func _on_Puzzle_harder() -> void:
	if not stop:
		$Tut_Hidden.visible = true
		stop = true
