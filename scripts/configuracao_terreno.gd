extends Node2D

@export_category("Atributos")
@export var map: tile_map
@export var tipo_pagamento: Texture2D
@export var preco: float
var file: Object
var top_left: Vector2i
var bottom_right: Vector2i


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


func _on_button_pressed():
	top_left = map.local_to_map($regiao/CollisionShape2D.global_position 
									- $regiao/CollisionShape2D.shape.extents)
	bottom_right = map.local_to_map($regiao/CollisionShape2D.global_position 
										+ $regiao/CollisionShape2D.shape.extents)
	
	if file != null and (file.get_path().get_file().replace(".png", "") == "coin") \
		and Global.moedas >= int(preco):
		Global.remove_coins(preco)
		map.modificar_celulas_posicoes(top_left, bottom_right)
		queue_free()
	elif file != null and (file.get_path().get_file().replace(".png", "") == "cristal") \
		and Global.cristais >= int(preco):
		Global.remove_cristals(preco)		
		map.modificar_celulas_posicoes(top_left, bottom_right)
		queue_free()		
	else:
		$regiao_gamer/slot_terrain/Panel/insuficiente.visible=true
		await(get_tree().create_timer(10).timeout)
		$regiao_gamer/slot_terrain/Panel/insuficiente.visible=false	
