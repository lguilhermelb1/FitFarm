extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var inv = $camera/Inventory


# 640 x 320
func _ready():	
	$camera/Inventory/ScrollContainer/GridContainer.main_update()
	inv.visible = false
	atualizar()
					
	get_window().size = Vector2(640, 320)
	player.position = Vector2(330,200)
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	
	#if global.tempo_final != null:
	#	print("V")
		#$camera/Control/label_tempo_final.text = "%02d : %02d" % [int(Global.tempo_final.time_left/60), 
		#											int(fmod(Global.tempo_final.time_left, 60))]
	player.follow_camera(camera) 
	
	update_values()


func _on_button_label_inventory_pressed():
	if (get_tree().get_root().get_node("Dialog_Node") == null):
		inv.visible = true


func update_values():
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	

func atualizar():	
	# armazene valores de strings
	
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
				nd.get_node("main_image").texture = load(x['icon'])
				print(nd.get_children())
				nd.set_current_timer(x['current_time'])		
				nd.play_animation()				
				self.get_node("vegetable_grid_container").inserir(nd)				
				print("Paused: ", nd.get_timer().is_stopped())
				
	Global.att_db()		

	
	
				
func _area_inserir():
	for area in get_tree().get_nodes_in_group("insercao_celeiro"):
		if area.get_child_count() == 1:
			return area
			break
	return null		
	
