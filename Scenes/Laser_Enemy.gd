extends "res://Scenes/Laser.gd"


func _ready():
#	connect("area_entered", self, "_on_area_entered")  # manually connecting a signal
	$AudioStreamPlayer2D.play()
	pass

func _on_area_entered(area):
	if area.is_in_group("ship"):
		area.armor -= 1
		create_flare()
		queue_free()
