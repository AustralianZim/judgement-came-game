extends HBoxContainer

const SCORE_INC = 123

var score = 0
var free_guesses = 5
var bonus = 5

func use_hint() -> void:
	if free_guesses > 0:
		free_guesses -= 1
		$Free_Guesses.text = ""
		for i in range(free_guesses):
			$Free_Guesses.text += "*"
		return
	
	if bonus > 1:
		bonus -= 1
		$Bonus.text = str(bonus)

func completed(cheat:bool) -> void:
	$completed.play()
	
	if not cheat:
		score += SCORE_INC * bonus
	$Score.text = str(score)
	
	bonus = 5
	free_guesses = 6
	use_hint() # decrements free_guesses
	$Bonus.text = str(bonus)
