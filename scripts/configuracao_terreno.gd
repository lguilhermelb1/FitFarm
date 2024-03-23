extends Node2D

@export var map: tile_map
@export var tipo_pagamento: Texture2D
@export var preco: float
var file: Object



#Position: (770, -344), MAP: (48, -22)
#SIZE: (507, 528)
#WIDTH_HEIGHT: (31, 33)
#(33, -38)/(63, -6)


#Position: (213, -344), MAP: (13, -22)
#SIZE: (589, 527)
#WIDTH_HEIGHT: (36, 32)
#(-5, -38)/(31, -6)


#	var lt = get_used_cells_by_id(0, 0, Vector2i(3,1))	# permitido passagem 
# 	var lt2 = get_used_cells_by_id(0, 4, Vector2(2,4))  # bloqueado

# Padrão (400,528)
# Mais_Alta (X, 528)
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
	
	var position_on_map = map.local_to_map(position)
	var width_height = map.local_to_map($regiao/CollisionShape2D.shape.get_rect().size)
		
	var pos1 = Vector2(position_on_map[0] - width_height[0]/2, position_on_map[1] - width_height[1]/2)
	var pos2 = Vector2(position_on_map[0] + width_height[0]/2, position_on_map[1] + width_height[1]/2)
	
	# (Terreno3 - (223,-343), W_H (591, 528)
	if name in  "Terreno_A_Comprar13" or  name == "Terreno_A_Comprar14" \
		or name == "Terreno_A_Comprar15" or  name == "Terreno_A_Comprar16" \
		or name == "Terreno_A_Comprar3" or  name == "Terreno_A_Comprar7":
		print(name)
		print("Position: ", position,", MAP: ", map.local_to_map(position))
		print("SIZE: ", $regiao/CollisionShape2D.shape.get_rect().size)
		print("WIDTH_HEIGHT: ", width_height)
		print(pos1, "/", pos2, "\n\n")


	# (32-38), (32,-6)
	# (32-38), (63,-6)
	map.set_cell(0, pos1, 9, Vector2(3,1))
	map.set_cell(0, pos2, 9, Vector2(3,1))


func _on_regiao_gamer_body_entered(body):
	if body.is_in_group("player"):
		$regiao_gamer/slot_terrain.visible=true


func _on_regiao_gamer_body_exited(body):
		if body.is_in_group("player"):
			$regiao_gamer/slot_terrain.visible=false


func _definicao_posicoes() :
	var position_on_map = map.local_to_map(position)
	var width_height = map.local_to_map($regiao/CollisionShape2D.shape.get_rect().size)
	var p1 = Vector2(position_on_map[0] - width_height[0]/2, position_on_map[1] - width_height[1]/2)
	var p2 = Vector2(position_on_map[0] + width_height[0]/2, position_on_map[1] + width_height[1]/2)
	return [p1, p2]


func _on_button_pressed():
	var lt_pos = _definicao_posicoes()
	
	if file != null and (file.get_path().get_file().replace(".png", "") == "coin") \
		and Global.moedas >= float(preco):
		Global.remove_coins(preco)
		map.modificar_celulas_posicoes(lt_pos[0], lt_pos[1])
		
	elif file != null and (file.get_path().get_file().replace(".png", "") == "cristal") \
		and Global.cristais > float(preco):
		Global.remove_cristals(preco)		
		map.modificar_celulas_posicoes(lt_pos[0], lt_pos[1])
	else:
		print("K")
		$regiao_gamer/slot_terrain/Panel/insuficiente.visible=true
		#await(10000)
		#$regiao_gamer/slot_terrain/Panel/insuficiente.visible=false	
	
		

