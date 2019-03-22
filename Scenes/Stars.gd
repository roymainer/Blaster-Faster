extends Sprite

export var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	translate(velocity * delta)
	
#	print(self.name + " " + str(global_position.y) + " " + str(get_viewport_rect().size.y))
	
	if position.y >= get_viewport_rect().size.y:
		position.y = -180
		