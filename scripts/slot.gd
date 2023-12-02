extends Panel


var _global = null
var _pagamento = null

func _ready():
	$result.visible = false

func set_pagamento(tipo_pagamento: String):
	_pagamento = tipo_pagamento


func setGlobal(glb):
	_global = glb

func verificacao():
	if ((_pagamento == "cristal" and _global.get_cristais() >= int($preco.text)
	and int($quantidade_disponivel.text) > 0) or (_pagamento == "coin" and 
	_global.get_moedas() >= int($preco.text) and int($quantidade_disponivel.text) > 0) ):
		return true
	else:
		return false

func efetuar_pagamento():

	if (_pagamento == "cristal" and int($quantidade_disponivel.text) > 0):
		_global.remove_cristals(int($preco.text))
		$quantidade_disponivel.text = str(int($quantidade_disponivel.text) - 1)
	
	elif (_pagamento == "coin" and int($quantidade_disponivel.text) > 0):
		_global.remove_coins(int($preco.text))
		$quantidade_disponivel.text = str(int($quantidade_disponivel.text) - 1)

func _on_gui_input(event):

	if event is InputEventScreenTouch and event.is_pressed():
		
		if verificacao():
			var node_animal = load("res://actors/" + 
			$icon.texture.get_path().get_file().replace(".png", "") + ".tscn")
			
			if node_animal != null:
				var animal = node_animal.instantiate()
				animal.set_script(load("res://scripts/animal_script.gd"))
				animal.position = get_tree().get_root().get_child(0).get_node("area_insercao_animal/CollisionShape2D").position
				
				get_tree().get_root().get_child(0).add_child(animal)
				efetuar_pagamento()
				
			else:
				var main_container = _container_nao_lotado()
				
				if main_container != null:
					var node_vegetable = load("res://prefab/vegetable.tscn").instantiate()
					node_vegetable.get_node("main_image").texture = $icon.texture
					
					main_container.inserir(node_vegetable)
					node_vegetable.start()
					efetuar_pagamento()

		elif int($quantidade_disponivel.text) == 0:
			_mudanca_texto("INDISPONÍVEL")
		else:
			_mudanca_texto("INSUFICIENTE")


func _container_nao_lotado() -> vegetables_grid:
	for container in get_tree().get_nodes_in_group("plantacao"):
		if container.lotado() == false:
			return container
			break
	return null								


func _mudanca_texto(frase: String):
	$timer.wait_time = 5
	$result.text =  frase
	$result.visible = true
	$timer.start()


func _on_timer_timeout():
	$timer.stop()
	$result.visible = false
