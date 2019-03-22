extends Node

onready var camera = $Camera2D

var magnitude = 0
var timeleft = 0
var is_shaking = false

func _ready():
	$Ship.connect("screen_shake", self, "shake")
	$AudioStreamPlayer.play()
	pass

func shake(new_magnitude=1, lifetime=0.13):
	
	if magnitude > new_magnitude:
		return

	magnitude = new_magnitude
	timeleft = lifetime

	if is_shaking:
		return

	is_shaking = true

	while timeleft > 0:
		var pos = Vector2()
		pos.x = rand_range(-magnitude, magnitude)
		pos.y = rand_range(-magnitude, magnitude)

		camera.offset = pos

		timeleft -= get_process_delta_time()
		yield(get_tree(), "idle_frame")

	magnitude = 0
	is_shaking = false
	camera.offset = Vector2()
	pass
	

func _on_Button_Menu_pressed():
	get_tree().change_scene("res://Stages/Main_Menu.tscn")


func _on_Ship_tree_exited():
	$HUD/Button_Menu.show()
