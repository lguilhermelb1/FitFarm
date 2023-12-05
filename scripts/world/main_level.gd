extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var inv = $camera/Inventory


# 640 x 320
func _ready():	
	print(Global.lista)
	$camera/Inventory/ScrollContainer/GridContainer.main_update()
	inv.visible = false
				
	get_window().size = Vector2(640, 320)
	player.position = Vector2(330,200)
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	
	#$camera/Control/label_tempo_final.text = "%02d : %02d" % [int(Global.tempo_final.time_left/60), 
	#											int(fmod(Global.tempo_final.time_left, 60))]
	player.follow_camera(camera) 
	
	atualizar()
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
			
			if x['type'] == 'animal':
				nd.set_script(load("res://scripts/animal_script.gd"))
				nd.global_position = x['position']		
				nd.z_index=0		
				self.add_child(nd)	
					
			elif x['type'] == 'celeiro':
				nd.global_position = x['position'] 
				var area_inserir = _area_inserir()
				
				if area_inserir != null:
					self.add_child(nd)	
					area_inserir.add_child(nd)
												
			elif x['type'] == "vegetable":
				nd.get_node("main_image").texture = load(x['icon'])
				print(nd.visible)
				nd.global_position = x['position'] 
				nd.set_status(x['status'])
				nd.z_index=0
				
				self.get_node("vegetable_grid_container").inserir(nd)	
				nd.play_animation()

				
				

func _area_inserir():
	for area in get_tree().get_nodes_in_group("insercao_celeiro"):
		if area.get_child_count() == 1:
			return area
			break
	return null		
	


