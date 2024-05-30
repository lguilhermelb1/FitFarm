extends Control

@onready var grid_container = %GridContainer
@onready var error_message = %Error_message
@onready var error_time_message = %Error_Time_Message
@onready var pin = %PIN
@onready var tempo = %Tempo
@onready var scroll_container = %ScrollContainer
var keyboard_height = 0

func _process(_delta):
	if(DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD)):
		var new_keyboard_height = DisplayServer.virtual_keyboard_get_height()
		if(keyboard_height == 0 and new_keyboard_height != 0):
			keyboard_height = new_keyboard_height
			scrollcontainer_fit_keyboard(true)
		elif(keyboard_height != 0  and new_keyboard_height == 0):
			keyboard_height = new_keyboard_height
			scrollcontainer_fit_keyboard(false)
			#
func _ready():
	clean_error_messages()
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	const exercise_list = [
		{"label": "Apoio de Frente", "image": "flexão.png"},
		{"label": "Rosca com Peso", "image": "rosca.png"},
		{"label": "Arremessar bola (acompanhado ou só)", "image": "Arremessar bola.png"},
		{"label": "Sentar e Levantar", "image": "sentar e levantar.png"},
		{"label": "Corrida Lateral", "image": "corrida.png"},
		{"label": "Saltos (Pular corda ou afins)", "image": "saltos.png"},
		{"label": "Outros", "image": "Outros.png"}
	]
	for exercise in exercise_list:	
		var texture = load("res://assets/Exercicies/" + exercise["image"])
		var texture_rect = TextureRect.new()
		texture_rect.texture = texture
		grid_container.add_child(texture_rect)

		
		var label = Label.new()
		label.add_theme_font_size_override("font_size", 30)
		label.text = exercise["label"]
		label.theme = load("res://themes/light_theme.tres")
		label.theme_type_variation = "ExerciseLabel"
		
	
		grid_container.add_theme_constant_override("h_separation", 50)
		grid_container.add_theme_constant_override("v_separation", 30)
		grid_container.add_child(label)

func _on_button_pressed():
	clean_error_messages()
	if Global.pin != pin.text:
		error_message.text = "PIN INVÁLIDO, INSIRA NOVAMENTE"
	
	elif int(tempo.text) == 0:
		error_time_message.text = "TEMPO LIMITE INVÁLIDO, INSIRA NOVAMENTE"
		error_time_message.visible=true
		await(get_tree().create_timer(3).timeout)
		error_time_message.visible=false
		
	elif int(tempo.text) < 20 or int(tempo.text) > 120 and tempo.editable == true:
		error_time_message.text = "O TEMPO LIMITE DEVE SER ENTRE 20 e 120 minutos"

		
	else: 
		Global.atualizar_tempo_transicao(int(tempo.text)*60)
		change_scene(Global.MAIN_GAME_SCENE)



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
						
					

func scrollcontainer_fit_keyboard(is_keyboard_visible:bool, ):
	if is_keyboard_visible:
		scroll_container.size.y -= 300
		await get_tree().process_frame
		var scroller = scroll_container.get_v_scroll_bar()
		scroller.value = scroller.max_value
	else:
		scroll_container.size.y += 300

func clean_error_messages():
	error_message.text = ""
	error_time_message.text = ""


