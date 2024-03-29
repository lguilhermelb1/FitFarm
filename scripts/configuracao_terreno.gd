extends Node2D

@export_category("Atributos")
@export var map: tile_map
@export var tipo_pagamento: Texture2D
@export var preco: float
@export var label_moedas: Label
@export var label_cristais: Label
var file: Object
var top_left: Vector2i
var bottom_right: Vector2i

var pos = null
var node = null

#	var lt = get_used_cells_by_id(0, 0, Vector2i(3,1))	# permitido passagem 
# 	var lt2 = get_used_cells_by_id(0, 4, Vector2(2,4))  # bloqueado

func _ready():	
	$regiao_gamer/slot_terrain/Panel/type_payment.texture = tipo_pagamento
	$regiao_gamer/slot_terrain/Panel/price.text = str(preco)
	
	$regiao_gamer/slot_terrain/Panel/insuficiente.visible = false
	file = $regiao_gamer/slot_terrain/Panel/type_payment.texture
	
	if file != null and (file.get_path().get_file().replace(".png", "") == "coin"):
		$regiao_gamer/slot_terrain/Panel/type_payment.transform[0][0] = 2
		$regiao_gamer/slot_terrain/Panel/type_payment.transform[1][1] = 2
	elif file != null and (file.get_path().get_file().replace(".png", "") == "cristal"):
		$regiao_gamer/slot_terrain/Panel/type_payment.transform[0][0] = .3
		$regiao_gamer/slot_terrain/Panel/type_payment.transform[1][1] = .3

	$regiao_gamer/slot_terrain.visible=false
	
	if name == "Terreno_A_Comprar12":
		print(get_children())
	
	
func _on_regiao_gamer_body_entered(body):
	if body.is_in_group("player"):
		$regiao_gamer/slot_terrain.visible=true


func _on_regiao_gamer_body_exited(body):
		if body.is_in_group("player"):
			$regiao_gamer/slot_terrain.visible=false


#func _definicao_posicoes() :
#	var position_on_map = map.local_to_map(position)
#	var width_height = map.local_to_map($regiao/CollisionShape2D.shape.get_rect().size)
#	var p1 = Vector2(position_on_map[0] - width_height[0]/2, position_on_map[1] - width_height[1]/2)
#	var p2 = Vector2(position_on_map[0] + width_height[0]/2, position_on_map[1] + width_height[1]/2)
#	return [p1, p2]

#func dentro_area(pos):
#	pos_mapa = map.local_to_map(pos)
#	top_left = map.local_to_map($regiao/CollisionShape2D.global_position 
#								- $regiao/CollisionShape2D.shape.extents)
#	bottom_right = map.local_to_map($regiao/CollisionShape2D.global_position 
#									+ $regiao/CollisionShape2D.shape.extents)
#									
#	print("POS_MAPA: ", pos_mapa, "\n", top_left, " ; ", bottom_right, "\n")
#	
#	return ((top_left[0] >= pos_mapa[0] and pos_mapa[0] <= bottom_right[0])  
#			and (top_left[1] >= pos_mapa[1] and pos_mapa[1] <= bottom_right[1]))


func _on_button_pressed():
	top_left = map.local_to_map($regiao/CollisionShape2D.global_position 
								- $regiao/CollisionShape2D.shape.extents)
	bottom_right = map.local_to_map($regiao/CollisionShape2D.global_position 
									+ $regiao/CollisionShape2D.shape.extents)
	
	if file != null and (file.get_path().get_file().replace(".png","") == "coin") \
		and Global.moedas >= int(preco):
			
		Global.remove_coins(preco)
		label_moedas.text = "%08d" % Global.moedas
		
		node = retorno_objetos("celeiro")
		remocao_valores(node)
		
		node = retorno_objetos("plantacao")
		remocao_valores(node)
						
		map.modificar_celulas_posicoes(top_left, bottom_right)
		
		Global.lista.append({"type": "terreno",
			"name": name, "cords": [top_left, bottom_right]
		}) 
						
		queue_free()
		
	elif file != null and (file.get_path().get_file().replace(".png","") == "cristal") \
		and Global.cristais >= int(preco):
		
		Global.remove_cristals(preco)		
		label_cristais.text = "%08d" % Global.cristais
		
		node = retorno_objetos("celeiro")
		remocao_valores(node)
		
		node = retorno_objetos("plantacao")
		remocao_valores(node)
		
		map.modificar_celulas_posicoes(top_left, bottom_right)
		
		Global.lista.append({"type": "terreno",
			"name": name, "cords": [top_left, bottom_right]
		}) 
				
		queue_free()		
	else:
		$regiao_gamer/slot_terrain/Panel/insuficiente.visible=true
		await(get_tree().create_timer(10).timeout)
		$regiao_gamer/slot_terrain/Panel/insuficiente.visible=false	
		

func busca_valor(name_group: String, name_object: String):
	for x in get_children():
		if len(x.get_groups()) > 0 and x.get_groups()[0] == name_group and x.name == name_object:
			return x
	return null


func retorno_objetos(name_group):
	var lt = []
	for x in get_children():
		if len(x.get_groups()) > 0 and x.get_groups()[0] == name_group:
			lt.append(x)
	return lt


func remocao_valores(nd):
	for x in nd:
		pos = null
		if x != null:
			pos = x.global_position
			remove_child(x)
			get_parent().add_child(x)				
			x.position = pos
