extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var hud = %HUD


var nd = null
var nodes_celeiro = null
var nodes_plantacao = null

# Nos Terrenos o que falta
# 1) desconfundir o cenário
# 2) condição de inserir caso não esteja dentro da área planejada
# 3) Atualziar os valores comprados no terreno
# 4) Problema na Inserção do celeiro

# 640 x 320
func _ready():	
	print(get_tree().get_nodes_in_group("insercao_celeiro"))

	Global.setTransition($camera/transition)
	print("NOVO_TEMPO: ", Global.tempo_final.wait_time)
	atualizar()
	
	if Global.time_label == null:
		Global.createTimeLabel()
		
	Global.time_label.position = Vector2(500,25)	
	Global.time_label.scale = Vector2(1.2, 1.2)	
	
	
	print(get_node("Terreno_A_Comprar"))
	Global.tempo_final.start()
	print("Started")



	if Global.status == false:	
		$Worker.queue_free()
	
	player.position = Vector2(330,200)
	$celeiro.change_visibility()
	player.follow_camera(camera) 



func update_values():
	hud.update_values_resources()
	
	
func atualizar():		
	for x in Global.lista:
		if x != null:
			if x['type'] == 'terreno':
				nodes_celeiro = get_node(str(x['name'])).retorno_objetos("celeiro")
				get_node(str(x['name'])).remocao_valores(nodes_celeiro)
				
				nodes_plantacao = get_node(str(x['name'])).retorno_objetos("plantacao")
				get_node(str(x['name'])).remocao_valores(nodes_plantacao)

				var cords = x['cords']
				# Verifica se a lista de coordenadas existe e tem pelo menos dois elementos
				if cords and cords.size() >= 2:
					# Processa a primeira string para obter os valores numéricos
					var coords_1 = str(cords[0]).replace("(", "").replace(")", "").split(",")

					var x_1 = float(coords_1[0])
					var y_1 = float(coords_1[1])
					
					# Processa a segunda string para obter os valores numéricos
					var coords_2 = str(cords[1]).replace("(", "").replace(")", "").split(",")
					var x_2 = float(coords_2[0])
					var y_2 = float(coords_2[1])
					
					# Cria os Vector2 com os valores obtidos
					var vector2_cords_1 = Vector2(x_1, y_1)
					var vector2_cords_2 = Vector2(x_2, y_2)

					# Chama o método modificar_celulas_posicoes com os Vector2 criados
					$mapa.modificar_celulas_posicoes(vector2_cords_1, vector2_cords_2)
				else:
					print("Erro: Lista de coordenadas ausente ou incompleta.")

				get_node(str(x['name'])).queue_free()
			
			elif x['type'] == "celeiro":
				_buscar_celeiro(x['name']).change_visibility()
			else:
				nd = load(x['node']).instantiate()	
				nd.z_index=0
					
				if x['type'] == 'animal':
					nd.set_script(load(x['script']))
					nd.global_position = x['position']	
					_buscar_celeiro(x['local_insercao']).append_animal(nd)	
					self.add_child(nd)	
													
				elif x['type'] == "vegetable":
					nd.get_node("main_image").texture = load(x['icon'])
					nd.set_current_timer(x['current_time'])		
					nd.set_status(x['status'])			
					self.get_node(str(x['parent'])).inserir(nd)


func _buscar_celeiro(name:String):
	for celeiro in get_tree().get_nodes_in_group("celeiro"):
		if celeiro.name == name:
			return celeiro
			break
	return null		




