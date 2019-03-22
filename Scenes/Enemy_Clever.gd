extends "res://Scenes/Enemy.gd"

onready var extents = $CollisionShape2D.shape.extents

const laser_scene = preload("res://Scenes/Laser_Enemy.tscn")

func _ready():
	randomize()
	velocity.x *= pow(-1, randi() % 2)
	yield(get_tree().create_timer(1), "timeout")
	shoot()	
	
func _physics_process(delta):
#	print(str(velocity))
	if position.x <= 0 + extents.x:
		velocity.x *= -1
	elif position.x >= get_viewport().get_visible_rect().size.x - extents.x:
		velocity.x *= -1
		
		
func shoot():
	while true:
		var laser = laser_scene.instance()
		laser.position = $Cannon.global_position
		get_tree().get_root().call_deferred("add_child", laser)
		yield(get_tree().create_timer(0.5),"timeout")