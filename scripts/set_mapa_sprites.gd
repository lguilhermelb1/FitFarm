extends TileMap


#	var lt = get_used_cells_by_id(0, 0, Vector2i(3,1))	# permitido passagem 
# 	var lt2 = get_used_cells_by_id(0, 4, Vector2(2,4))  # bloqueado


func modificar_celulas_posicoes(pos1: Vector2i, pos2: Vector2i):
	for x in range(pos1[0], pos2[0]):
		for y in range(pos1[1], pos2[1]):
			print(x, ";", y)
			# layer (camada), posicao do mapa, posicao do tileset, posicao da figura	
			set_cell(0, Vector2(x,y), 0, Vector2(3,1))
	
	
	# OBS: provavelmente teria que salvar as coordenadas que estão 
	# de verde para poder atualizar o mapa


