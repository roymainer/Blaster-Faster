extends Node

const powerups = [
				preload("res://Scenes/Powerup_Armor.tscn"),
				preload("res://Scenes/Powerup_Laser.tscn")
				]

func _ready():
	randomize()
	yield(get_tree().create_timer(rand_range(8, 12)), "timeout")
	spawn()
	pass

func spawn():

	while true:
		var powerup = powerups[randi() % powerups.size()].instance()
		var pos = Vector2()
		var extents = powerup.get_node("CollisionShape2D").shape.extents
		pos.x = rand_range(0 + extents.x, get_viewport().get_visible_rect().size.x - extents.x)
		pos.y = -extents.y
		powerup.set("position", pos)
		$Container.add_child(powerup)

		yield(get_tree().create_timer(rand_range(8, 12)), "timeout")  