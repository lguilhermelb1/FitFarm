extends Panel

var _pagamento = null
var _label_cristals = null
var _label_moedas = null

func _ready():
	$result.visible = false
	await(get_tree().current_scene.name == "Mundo01")
	_label_cristals = get_tree().current_scene.get_node("camera").get_node("Control").get_node("label_cristais")
	_label_moedas = get_tree().current_scene.get_node("camera").get_node("Control").get_node("label_moedas")


func set_pagamento(tipo_pagamento: String):
	_pagamento = tipo_pagamento


func efetuar_pagamento():
	if (_pagamento == "cristal"):
		Global.remove_cristals(int($preco.text))
		_label_cristals.text = "%08d" % Global.cristais
		
	elif (_pagamento == "coin"):
		Global.remove_coins(int($preco.text))
		_label_moedas.text = "%08d" % Global.moedas


func _on_gui_input(event):
	
	if event is InputEventScreenTouch and event.is_pressed():
	
		if ((_pagamento == "cristal" and Global.cristais >= int($preco.text)) \
			or (_pagamento == "coin" and Global.moedas >= int($preco.text))):
		
			var file_name = $icon.texture.get_path().get_file().replace(".png", "")
			
			if file_name== "coin":
				efetuar_pagamento()
				Global.add_coins(20)	
				_label_moedas.text = "%08d" % Global.moedas
				Global.att_db()
									
			elif file_name == "celeiro":
				var node_celeiro = load("res://prefab/celeiro.tscn").instantiate()
				var area_insercao = _area_inserir()
				print(area_insercao)
				
				if area_insercao != null:
					node_celeiro.position.x = area_insercao.global_position.x
					node_celeiro.position.y = area_insercao.global_position.y
		
					Global.lista.append({"type": "celeiro",
						"node": "res://prefab/celeiro.tscn", 
						"position": area_insercao.global_position})
						
					get_tree().get_root().add_child(node_celeiro)	
					area_insercao.add_child(node_celeiro)
			else:
				var node_animal = load("res://actors/" + file_name + ".tscn")
				var container = _celeiro_vazio()
									
				if node_animal != null and container != null:
						node_animal = node_animal.instantiate()
						node_animal.z_index = 0
						node_animal.set_script(load("res://scripts/animal_script.gd"))
						node_animal.position = container.get_node("area2d/collision").transform.origin
											
						container.get_node("area2d").add_child(node_animal)
						print("GB: ", node_animal.global_position)
						Global.lista.append({"type": "animal",
						"node": "res://actors/" + file_name + ".tscn", 
						"script": "res://scripts/animal_script.gd",
						"position": node_animal.global_position})	
						Global.att_db()								
						efetuar_pagamento()
						
				elif node_animal == null:
					container = _container_nao_lotado()
					
					if container != null:
						var node_vegetable: vegetable_item = load("res://prefab/vegetable.tscn").instantiate()
						node_vegetable.get_node("main_image").texture = $icon.texture
						node_vegetable.z_index = 0
						container.inserir(node_vegetable)
						
						Global.lista.append({
							"type": "vegetable",
							"node": "res://prefab/vegetable.tscn", 
							"icon": node_vegetable.get_node("main_image").texture.get_path(),
							"status": node_vegetable.get_status(), 
							"position": node_vegetable.global_position,
							'current_time': 7})
						Global.att_db()
						node_vegetable.play_animation()
						efetuar_pagamento()
		else:
			_mudanca_texto("INSUFICIENTE")
		
	
func _container_nao_lotado() -> vegetables_grid:
	for container in get_tree().get_nodes_in_group("plantacao"):
		if container.lotado() == false:
			return container
			break
	return null			
		
func _celeiro_vazio() -> barn:
	for celeiro in get_tree().get_nodes_in_group("celeiro"):
		if celeiro.lotado() == false:
			return celeiro
			break
	return null		
	
func _area_inserir():
	for area in get_tree().get_nodes_in_group("insercao_celeiro"):
		if area.get_child_count() == 1:
			return area
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
