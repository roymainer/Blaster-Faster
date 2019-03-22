extends Node

func _ready():
	$AudioStreamPlayer.play()
	$HUD/Score_Panel/Score.text = str(game.best_score)
	pass


func _on_Button_Start_pressed():
	get_tree().change_scene("res://Stages/World.tscn")


func _on_Button_Quit_pressed():
	get_tree().quit()
