extends Sprite

func _ready():
	randomize()
	$AudioStreamPlayer2D.play()
	rotation = deg2rad(rand_range(0, 360))
	$Particles2D_Flares.emitting = true
	$Particles2D_Smoke.emitting = true
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer, "animation_finished")
	queue_free()  
	pass
