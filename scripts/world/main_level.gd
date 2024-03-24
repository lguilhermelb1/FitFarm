extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var inv = $camera/Inventory

# Nos Terrenos o que falta
# 1) adicionar os terrenos mais caros
# 2) condição de inserir caso não esteja dentro da área planejada
# 3) Atualziar os valores comprados no terreno
# 4) Corrigr o bug do celeiro


# 640 x 320
func _ready():	
	$camera/Inventory/ScrollContainer/GridContainer.main_update()
	inv.visible = false
	
	Global.setTransition($camera/transition)
	print("NOVO_TEMPO: ", Global.tempo_final.wait_time)
	atualizar()
		
	if Global.time_label == null:
		Global.time_label = Label.new()
		
	Global.time_label.position = Vector2(-60,-70)
	Global.time_label.scale = Vector2(.6, .6)
	$camera/Control.add_child(Global.time_label)
	Global.tempo_final.start()
	print("Started")
	
	get_window().size = Vector2(640, 320)
	if Global.status == false:	
		$Worker.queue_free()
	
	player.position = Vector2(330,200)
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	
	player.follow_camera(camera) 
	#update_values()
	_area_inserir()


#func _process(delta):
#	Global.setLabelTime()


func _on_button_label_inventory_pressed():
	if (get_tree().get_root().get_node("Dialog_Node") == null):
		inv.visible = true


func update_values():
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	
	
func atualizar():		
	for x in Global.lista:
		if x != null:	
			var nd = load(x['node']).instantiate()	
			nd.z_index=0
					
			if x['type'] == 'animal':
				print("VALOR_ANIMAL: ", x)
				nd.set_script(load(x['script']))
				nd.global_position = x['position']		
				self.add_child(nd)	
				
			elif x['type'] == 'celeiro':
				nd.global_position = x['position'] 
				var area_inserir = _area_inserir()
				
				if area_inserir != null:
					self.add_child(nd)	
					area_inserir.add_child(nd)
												
			elif x['type'] == "vegetable":
				nd.get_node("main_image").texture = load(x['icon'])
				nd.set_current_timer(x['current_time'])		
				nd.set_status(x['status'])					
				self.get_node("vegetable_grid_container").inserir(nd)
	
	Global.att_db()		
	
	
# OBS: na area de inserir teria que verificar se a posição está dentro da area bloqueada
func _area_inserir():
	for area in get_tree().get_nodes_in_group("insercao_celeiro"):
		if area.get_child_count() == 1:
			return area
			break
	return null		


#func checagem_area_bloqueada(area_posicao):
#	var lt = get_node("mapa").get_used_cells_by_id(0, 4, Vector2(2,4))
#	area_posicao = Vector2i(int(area_posicao[0]), int(area_posicao[1]))
#	return area_posicao in lt
	

#func update_timer():
#	if Global.tempo_final != null:		
#		$camera/tempo_final/label_tempo_final.text = "%02d : %02d" % \
#		[(int(Global.tempo_final.time_left/60)), (int(fmod(Global.tempo_final.time_left, 60)))]
#		Global.tempo_final.wait_time = Global.tempo_final.time_left
