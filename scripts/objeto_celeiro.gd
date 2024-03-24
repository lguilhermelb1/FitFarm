extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if name == "objeto_celeiro":
		$CollisionShape2D.shape.size.x = 22
		$CollisionShape2D.shape.size.y = 30
	elif name == "objeto_celeiro2":
		$CollisionShape2D.shape.size.x = 8
		$CollisionShape2D.shape.size.y = 8
