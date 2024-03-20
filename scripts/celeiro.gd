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
	print(sprite)
	if sprite == "celeiro_aberto":
		$AnimationPlayer.play_backwards("door")
		#await($AnimationPlayer.animation_finished)
		
	elif sprite == "celeiro_fechado":
		$AnimationPlayer.play("door")
		#await($AnimationPlayer.animation_finished)
