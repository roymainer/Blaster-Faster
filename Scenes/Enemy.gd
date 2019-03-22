extends Area2D

const explosion_scene = preload("res://Scenes/Explosion.tscn")

export var velocity = Vector2()
export var armor = 2 setget set_armor

signal screen_shake
signal enemy_destroyed


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_on_area_enter")
	add_to_group("enemies")
	randomize()

func _physics_process(delta):
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y + $CollisionShape2D.shape.extents.y:
		queue_free()
		
		
func set_armor(value):
	
	if is_queued_for_deletion():
		# make sure the enemy ship doesn't explode twice
		return
	
	if armor > value:
		$AudioStreamPlayer2D.play()
		emit_signal("screen_shake")
	
	armor = value
	if armor <= 0:
		emit_signal("enemy_destroyed", 5)
		create_explosion()
		queue_free()
		
func _on_area_enter(area):
	if area.is_in_group("ship"):
		area.armor -= 1
		create_explosion()
		queue_free()
		
func create_explosion():
	var explosion = explosion_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)