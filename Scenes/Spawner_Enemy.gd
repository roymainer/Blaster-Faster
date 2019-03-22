extends Node

const enemies = [
				preload("res://Scenes/Enemy_Clever.tscn"),
				preload("res://Scenes/Enemy_Kamikaze.tscn")
				]

func _ready():
	randomize()
	yield(get_tree().create_timer(2), "timeout")
	
	spawn()
	pass
	
func spawn():
	
	while true:
		var enemy = enemies[randi() % enemies.size()].instance()
		var pos = Vector2()
		var extents = enemy.get_node("CollisionShape2D").shape.extents
		pos.x = rand_range(0 + extents.x, get_viewport().get_visible_rect().size.x - extents.x)
		pos.y = -extents.y
		enemy.set("position", pos)
		$Container.add_child(enemy)
		enemy.connect("enemy_destroyed", get_parent().get_node("HUD"), "set_score")
		yield(get_tree().create_timer(rand_range(1, 1.75)), "timeout")  # delay the program for 0.5sec before looping and creating a new enemy