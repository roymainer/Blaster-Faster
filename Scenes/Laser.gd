extends Area2D

export var velocity = Vector2()

const flare_scene = preload("res://Scenes/Flare.tscn")

func _ready():
	create_flare()
	yield($VisibilityNotifier2D, "screen_exited")
	queue_free()
	pass

func _physics_process(delta):
	translate(velocity * delta)
	
func create_flare():
	var flare = flare_scene.instance()
	flare.position = position
	get_tree().get_root().call_deferred("add_child", flare)
	