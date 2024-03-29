extends Panel

var _pagamento = null
var _label_cristals = null
var _label_moedas = null
var main_map: tile_map

func _ready():
	$result.visible = false
	await(get_tree().current_scene.name == "Mundo01")
	main_map =  get_tree().current_scene.get_node("mapa")
	
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
				var node_celeiro = _buscar_celeiro()
				
				if node_celeiro != null:
					node_celeiro.change_visibility()
					
					Global.lista.append({"type": "celeiro",
					"name": node_celeiro.name, 
					"pos": global_position,
					"visible": true}) # "position": area_insercao.global_position
					
					efetuar_pagamento()
									
					#area_insercao.add_child(node_celeiro)			
					#get_tree().get_root().add_child(node_celeiro)	
				
				#var area_insercao = _area_inserir()
				
				#if area_insercao != null:
					#var pos_p = main_map.local_to_map(area_insercao.global_position)
					#print("Principal_posicao: ", pos_p)
					#node_celeiro.position.x = pos_p[0] # area_insercao.global_position.x
					#node_celeiro.position.y = pos_p[1] # area_insercao.global_position.y
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
						print("Container_Insercao: ", container.name)						
						var node_vegetable: vegetable_item = load("res://prefab/vegetable.tscn").instantiate()
						node_vegetable.get_node("main_image").texture = $icon.texture
						node_vegetable.z_index = 0
						container.inserir(node_vegetable)
												
						Global.lista.append({
							"type": "vegetable",
							"node": "res://prefab/vegetable.tscn", 
							"icon": node_vegetable.get_node("main_image").texture.get_path(),
							"status": node_vegetable.get_status(), 
							"parent": container.name,
							"position": node_vegetable.global_position,
							'current_time': 7})
						
						Global.att_db()
						node_vegetable.play_animation()
						efetuar_pagamento()
					else:
						_mudanca_texto("INDISPONIVEL")
		else:
			_mudanca_texto("INSUFICIENTE")
		
	
func _container_nao_lotado() -> vegetables_grid:
	for container in get_tree().get_nodes_in_group("plantacao"):
		
		if container.lotado() == false and container.name=="vegetable_grid_container4":
			print("NOME_CONTAINER: ", container, " / ", container.lotado())
			print("DENTRO_TERRENO_A_COMPRAR: ", _verificacao_posicao(container.name, "plantacao"), "\n")
				
		if container.lotado() == false and _verificacao_posicao(container.name, "plantacao") == false:
			return container
	return null			




	
func _buscar_celeiro():
	for celeiro in get_tree().get_nodes_in_group("celeiro"):
		if celeiro.visivel == false and _verificacao_posicao(celeiro.name, "celeiro") == false:
			return celeiro
			break
	return null


func _celeiro_vazio() -> barn:
	for celeiro in get_tree().get_nodes_in_group("celeiro"):
		if celeiro.lotado() == false and celeiro.visivel==true:
			return celeiro
			break
	return null		
		

func _verificacao_posicao(name: String, tipo: String):
	for area in get_tree().get_nodes_in_group("terreno_compra"):
		if (area.busca_valor(tipo, name) != null):
			return true
	return false

		
func _mudanca_texto(frase: String):
	$timer.wait_time = 5
	$result.text =  frase
	$result.visible = true
	$timer.start()


func _on_timer_timeout():
	$timer.stop()
	$result.visible = false


#func _area_inserir():
#	for area in get_tree().get_nodes_in_group("insercao_celeiro"):	
#		if area.get_child_count() == 1 and \
#		_verificacao_posicao(area.get_children()[0].global_position) == true:
#			return area
#			break
#	return null	
