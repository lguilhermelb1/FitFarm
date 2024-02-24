extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready(): 
	#var lt = get_used_cells_by_id(0, 0, Vector2i(3,1))	
	#var lt2 = get_used_cells_by_id(0, 4, Vector2(2,4))
	pass
	
	
func modificar_celula_posicoes(pos1, pos2):
	# layer (camada), posicao do mapa, posicao do tileset, posicao da figura
	set_cell(0, Vector2(pos1,pos2), 0, Vector2(3,1))
	# OBS: provavelmente teria que salvar as coordenadas que estão 
	# de verde para poder atualizar o mapa


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
