extends Node2D

@export var map: TileMap
@export var tipo_pagamento: Texture2D
@export var preco: float
var file: Object
# 414x528, 406x528

func _ready():
	print("Position: ", position,", MAP: ", map.local_to_map(position))
	print("SIZE: ", $regiao/CollisionShape2D.shape.get_rect().size)
	
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
	

	
	print("WIDTH_HEIGHT: ", width_height)
	# problema na largura e na posição
	
	# (x - 12 = 89)
	print(25/2)
	
	var pos1 = Vector2(position_on_map[0] - width_height[0]/2, position_on_map[1] - width_height[1]/2)
	var pos2 = Vector2(position_on_map[0] + width_height[0]/2, position_on_map[1] + width_height[1]/2)
	print(pos1, "/", pos2, "\n\n")

	map.set_cell(0, pos1, 9, Vector2(3,1))
	map.set_cell(0, pos2, 9, Vector2(3,1))


func _on_regiao_gamer_body_entered(body):
	if body.is_in_group("player"):
		$regiao_gamer/slot_terrain.visible=true


func _on_regiao_gamer_body_exited(body):
		if body.is_in_group("player"):
			$regiao_gamer/slot_terrain.visible=false

func _on_button_pressed():
	print("V")
