extends Sprite2D

var texture_array: Array = [
	preload("res://assets/Exercicies/agachamento.jpg"),
	preload("res://assets/Exercicies/caminhada.jpg"),
	preload("res://assets/Exercicies/alongamento.jpg")
]

var tentativas
var contador
var rodando = false

func _ready():
	$info.visible=false
	print(texture)
	tentativas=3


func exercicio_aleatorio():
	if len(texture_array) > 0:
		var indice = randi() % texture_array.size()
		var chosen = texture_array[indice]
		texture = chosen
		

func _on_tente_novamente_pressed():
	if tentativas > 0 and rodando == false:
		tentativas -= 1
		contador = 100
		rodando = true
	elif tentativas== 0 and rodando == false:
		$info.visible=true
		await(get_tree().create_timer(7).timeout)
		$info.visible=false
		

func _process(delta):
	if rodando == true:
		if contador > 0:
			exercicio_aleatorio()
			contador -= 1 
			print(contador)
			
		if contador == 0:
			rodando = false
