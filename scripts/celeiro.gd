extends StaticBody2D
class_name barn

var permitido = false

func lotado():
	var cont = 0
		
	for x in $area2d.get_overlapping_bodies():
		if x.is_in_group("animal"):
			cont += 1			
	return cont == 4


func _on_area_porta_body_entered(body):
	if body.name == "player_world":
		play_open_door()

func _on_area_porta_body_exited(body):
	permitido = false
	play_open_door()


func play_open_door():
	var sprite = $Sprite2D.texture.get_path().get_file().replace(".png", "")
		
	if sprite == "celeiro_fechado":
		$Sprite2D.texture = load("res://assets/Objects/celeiro_aberto.png")
		$barreira_porta.disabled = true
	else:
		$Sprite2D.texture = load("res://assets/Objects/celeiro_fechado.png")
		$barreira_porta.disabled = false
