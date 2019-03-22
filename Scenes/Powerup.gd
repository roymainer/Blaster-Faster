extends Area2D

var velocity = Vector2(0, 200)
onready var extents = $CollisionShape2D.shape.extents

func _ready():
	pass


func _physics_process(delta):
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y + extents.y:
		queue_free()
	
	pass

func _on_Powerup_Armor_area_entered(area):
	if area.is_in_group("ship"):
		$AudioStreamPlayer2D.play()
		area.armor += 1
		queue_free()
	pass # Replace with function body.


func _on_Powerup_Laser_area_entered(area):
	if area.is_in_group("ship"):
		$AudioStreamPlayer2D.play()
		area.is_double_shooting = true
		queue_free()
	pass # Replace with function body.
