extends Node
@onready var pin = %PIN
@onready var tempo = %Tempo
@onready var button = %Button
@onready var error_message_pin = %ErrorMessagePin
@onready var error_message_time = %ErrorMessageTime


func _process(delta):
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false

func _on_button_pressed():
	clean_error_messages()	
	if Global.pin != pin.text:
		error_message_pin.text = "PIN inválido. Insira novamente."
	elif tempo.text == "":
		error_message_time.text = "Tempo limite inválido. Insira novamente"	
	elif int(tempo.text) < 1 or int(tempo.text) > 120 and tempo.editable == true:
		error_message_time.text = "O tempo limite deve ser entre 1 e 120 minutos"	
	else: 
		Global.atualizar_tempo_transicao(int(tempo.text)*60)
		change_scene(SceneGameManager.PATHS.MAIN_GAME_SCENE)

func change_scene(path: String):
	get_tree().paused = true
	_update_values()
	assert(SceneGameManager.change_scene_by_path(path) == OK)

func _update_values():
	if get_tree().current_scene.name == "Mundo01":
		for x in Global.lista:
			if 'position' in x.keys():
				for v in get_tree().get_nodes_in_group("vegetable"):
					if v.global_position == x['position']:				
						v.get_node("timer").paused=true
						x['current_time'] = v.get_node("timer").time_left	
						x['status'] = v.get_status()
						

func clean_error_messages():
	error_message_pin.text = ""
	error_message_time.text = ""
