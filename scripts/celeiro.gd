extends StaticBody2D
class_name barn

var visivel
var lista_animais = []
func _ready():
	if name != "celeiro":
		desabilitar()
	visivel=false

func desabilitar():
	$Collision1.disabled=true
	$Collision2.disabled=true
	$Collision3.disabled=true
	$Collision4.disabled=true
	$Collision5.disabled=true
	$objeto_celeiro/CollisionShape2D.disabled=true
	$objeto_celeiro2/CollisionShape2D.disabled=true
	
func habilitar():
	$Collision1.disabled=false
	$Collision2.disabled=false
	$Collision3.disabled=false
	$Collision4.disabled=false
	$Collision5.disabled=false
	$objeto_celeiro/CollisionShape2D.disabled=false
	$objeto_celeiro2/CollisionShape2D.disabled=false
	






func lotado():
	#var cont = 0
	#for x in $area2d.get_overlapping_bodies():
		#if x.is_in_group("animal"):
		#	cont += 1			
	return len(lista_animais) == 4

func append_animal(nd: Node2D):
	lista_animais.append(nd)

func _on_area_porta_body_entered(body):
	if body.name == "player_world":
		play_open_door()

func _on_area_porta_body_exited(body):
	play_open_door()


func play_open_door():
	var sprite = $Sprite2D.texture.get_path().get_file().replace(".png", "")
	if sprite == "celeiro_fechado" and visivel==true:
		$Sprite2D.texture = load("res://assets/Objects/celeiro_aberto.png")
		$barreira_porta.disabled = true
	elif sprite == "celeiro_aberto" and visivel==true:
		$Sprite2D.texture = load("res://assets/Objects/celeiro_fechado.png")
		$barreira_porta.disabled = false


func change_visibility():
	visivel=true
	habilitar()
	$Sprite2D.modulate.a=255
	$objeto_celeiro/Sprite2D.modulate.a=255
	$objeto_celeiro2/Sprite2D.modulate.a=255
