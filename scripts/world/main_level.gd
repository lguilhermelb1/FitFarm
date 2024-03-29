extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var inv = $camera/Inventory
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
	$camera/Inventory/ScrollContainer/GridContainer.main_update()
	inv.visible = false
	
	Global.setTransition($camera/transition)
	print("NOVO_TEMPO: ", Global.tempo_final.wait_time)
	atualizar()
	print(get_node("Terreno_A_Comprar"))
		
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
	$celeiro.change_visibility()
	print(get_tree().get_nodes_in_group("plantacao"))
	player.follow_camera(camera) 
	#update_values()
	#_area_inserir()


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
			if x['type'] == 'terreno':
				nodes_celeiro = get_node(str(x['name'])).retorno_objetos("celeiro")
				get_node(str(x['name'])).remocao_valores(nodes_celeiro)
				
				nodes_plantacao = get_node(str(x['name'])).busca_valor("plantacao")
				get_node(str(x['name'])).remocao_valor(nodes_plantacao)
			
				$mapa.modificar_celulas_posicoes(x['cords'][0], x['cords'][1])
				get_node(str(x['name'])).queue_free()
								
			elif x['type'] == "celeiro":
				_buscar_celeiro(x['name']).change_visibility()
			else:
				nd = load(x['node']).instantiate()	
				nd.z_index=0
					
				if x['type'] == 'animal':
					nd.set_script(load(x['script']))
					nd.global_position = x['position']		
					self.add_child(nd)	
													
				elif x['type'] == "vegetable":
					nd.get_node("main_image").texture = load(x['icon'])
					nd.set_current_timer(x['current_time'])		
					nd.set_status(x['status'])			
					self.get_node(str(x['parent'])).inserir(nd)
	
	Global.att_db()		


func _buscar_celeiro(name:String):
	for celeiro in get_tree().get_nodes_in_group("celeiro"):
		if celeiro.name == name:
			return celeiro
			break
	return null		


#func update_timer():
#	if Global.tempo_final != null:		
#		$camera/tempo_final/label_tempo_final.text = "%02d : %02d" % \
#		[(int(Global.tempo_final.time_left/60)), (int(fmod(Global.tempo_final.time_left, 60)))]
#		Global.tempo_final.wait_time = Global.tempo_final.time_left
