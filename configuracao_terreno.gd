extends Node2D


func _ready():
	print($regiao/CollisionShape2D.shape.size)
	$slot_terrain.visible=false

func _on_regiao_gamer_body_entered(body):
	if body.is_in_group("player"):
		print("Gostaria de Comprar")
		$slot_terrain.visible=true
			
		
func _on_regiao_gamer_body_exited(body):
		if body.is_in_group("player"):
			$slot_terrain.visible=false
