extends Area2D

const laser_scene = preload("res://Scenes/Laser_Ship.tscn")
const explosion_scene = preload("res://Scenes/Explosion.tscn")
const flash_scene = preload("res://Scenes/Flash.tscn")

export var armor = 4 setget set_armor

var is_double_shooting = false setget set_double_shooting

signal screen_shake
signal armor_changed

func _ready():
	add_to_group("ship")
	
	yield(get_tree().create_timer(0.5), "timeout")
	shoot()
	pass
	
func _physics_process(delta):
	# ship track the mouse
#	position.x = get_global_mouse_position().x
	position.x = lerp(position.x, get_global_mouse_position().x, 0.2)
	
	# clamping to view
	var view_size = get_viewport_rect().size
	var ship_size = $CollisionShape2D.shape.extents
	position.x = clamp(position.x, 0 + ship_size.x, view_size.x - ship_size.x)
	
	
func shoot():
	while true:
		
		var pos_left = $Cannons/Left.global_position
		var pos_right = $Cannons/Right.global_position
		create_laser(pos_left)
		create_laser(pos_right)
		
		if is_double_shooting:
			var laser_left = create_laser(pos_left)
			var laser_right = create_laser(pos_right)
			laser_left.velocity.x = -25  # make it move at an angle
			laser_right.velocity.x = 25  # make it move at an angle
					
		yield(get_tree().create_timer(0.25), "timeout")


func set_double_shooting(new_value):
	is_double_shooting = new_value
	
	if is_double_shooting:
		yield(get_tree().create_timer(5), "timeout")  # double shooting only lasts 5 seconds
		is_double_shooting = false
		
		
func create_laser(pos):
	var laser = laser_scene.instance()
	laser.position = pos
	get_tree().get_root().call_deferred("add_child", laser)
	return laser  # cause we'll need to make some changes to it
	
func set_armor(value):
	if value > 4: return
	
	if armor > value:
		$AudioStreamPlayer2D.play()
		var flash = flash_scene.instance()
		get_tree().get_root().call_deferred("add_child", flash)
		emit_signal("screen_shake")
	
	armor = value
	emit_signal("armor_changed", armor)
	
	if armor <= 0:
		create_explosion()
		queue_free()
	
	
func create_explosion():
	var explosion = explosion_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)
	

	