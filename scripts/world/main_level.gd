extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var inv = $camera/Inventory


# 640 x 320
func _ready():	
	$camera/Inventory/ScrollContainer/GridContainer.main_update()
	inv.visible = false
	atualizar()
	Global.setTransition($camera/transition)
	print("NOVO_TEMPO: ", Global.tempo_final.wait_time)
	
	if Global.tempo_final.wait_time != 0 and Global.tempo_final.is_stopped():
		Global.tempo_final.start()
		print(Global.tempo_final.time_left)		
		print("Started")
				
	get_window().size = Vector2(640, 320)
	if Global.status == false:	
		$Worker.queue_free()
	
	player.position = Vector2(330,200)
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	
	update_timer()
	
	player.follow_camera(camera) 
	update_values()


func _process(delta):
	update_timer()


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
				var animal_node = load(x['node']).instantiate()
				animal_node.set_script(load("res://scripts/animal_script.gd"))
				animal_node.global_position = x['position']		
				self.add_child(nd)	
					
			elif x['type'] == 'celeiro':
				nd.global_position = x['position'] 
				var area_inserir = _area_inserir()
				
				if area_inserir != null:
					self.add_child(nd)	
					area_inserir.add_child(nd)
												
			elif x['type'] == "vegetable":
				print("Valor: ", x)
				nd.get_node("main_image").texture = load(x['icon'])
				nd.set_current_timer(x['current_time'])		
				nd.set_status(x['status'])							
				self.get_node("vegetable_grid_container").inserir(nd)
	Global.att_db()		
	
	
func _area_inserir():
	for area in get_tree().get_nodes_in_group("insercao_celeiro"):
		if area.get_child_count() == 1:
			return area
			break
	return null		


func update_timer():
	if !Global.tempo_final.is_stopped():		
		$camera/tempo_final/label_tempo_final.text = "%02d : %02d" % \
		[(int(Global.tempo_final.time_left/60)), (int(fmod(Global.tempo_final.time_left, 60)))]
