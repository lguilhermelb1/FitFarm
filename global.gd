extends Node2D
class_name global_variables

# Pegar da base de dados
var cristais = 0
var moedas = 0
var user_id : String = ""
var user_key : String = ""
var pin : String = ""
var tempo_final : Timer
var lista = []
var status=true
var transition: Transition
var time_label: Label


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	tempo_final = Timer.new()
	tempo_final.wait_time = 300
	createTimeLabel()
	self.time_label.process_mode = Node.PROCESS_MODE_ALWAYS
	
	add_child(tempo_final)

	tempo_final.timeout.connect(on_tempo_final_timeout)	
	print(tempo_final.timeout.is_connected(on_tempo_final_timeout))
	

func createTimeLabel():
	self.time_label = Label.new()
	self.time_label.visible=false


func _process(delta):
	if !self.tempo_final.is_stopped() and self.time_label != null:
		setLabelTime()


func add_cristals(value):
	cristais += value 

func remove_cristals(value):
	cristais -= value

func add_coins(value):
	moedas += value 

func remove_coins(value):
	moedas -= value
	
func get_moedas():
	return moedas
	
func get_cristals():
	return cristais 


func att_db():
	var saveUserDataUrl = "https://db-nutricamp-default-rtdb.firebaseio.com/usuarios/" + user_id + "/" + user_key + ".json"
	var url = saveUserDataUrl
	
	# Solicitação para salvar dados no Realtime Database
	var request = HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(self._on_http_request_request_completed)
	
	# Dados iniciais do usuário
	var jsonObject = JSON.new()
	var initial_data = jsonObject.stringify({
		"pin": pin,
		"moedas": moedas,  # Valor inicial para moedas (ajuste conforme necessário)
		"cristais": cristais,  # Valor inicial para cristais (ajuste conforme necessário)
		"lista": lista
	})

	var headers = ['Content-Type: application/json']
	request.request(url, headers, HTTPClient.METHOD_PUT, initial_data)


func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Dados do usuário salvos com sucesso!")
	else:
		print("Falha ao salvar dados do usuário:", response_code)
		
		
func on_tempo_final_timeout():
	tempo_final.stop()
	tempo_final.wait_time=0
	transition.change_scene("res://scenes/exercice_time_scene.tscn")
	
	
func setTransition(t: Transition):
	self.transition = t


func atualizar_tempo_transicao(tempo):
	tempo_final.wait_time = tempo


func setLabelTime():
	if Global.tempo_final.time_left <= 150:	
		self.time_label.visible=true
		self.time_label.text = "Tempo Restante: %02d : %02d" % [(int(Global.tempo_final.time_left/60)), (int(fmod(Global.tempo_final.time_left, 60)))]

	Global.tempo_final.wait_time = Global.tempo_final.time_left	
