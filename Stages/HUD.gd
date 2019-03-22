extends CanvasLayer

var score = 0 setget set_score

func _ready():
	pass

func _on_armor_changed(value):
	$Armor.frame = value
	
func set_score(value=5):
	score += value
	$Score_Panel/Score.text = str(score)
	if score > game.best_score:
		game.best_score = score
	pass