extends "res://Scenes/Laser.gd"

func _ready():
	$AudioStreamPlayer2D.play()
	pass

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.armor -= 1
		create_flare()
		queue_free()
