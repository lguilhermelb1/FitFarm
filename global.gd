extends Node2D
class_name global_variables

# Pegar da base de dados
var cristais = 0
var moedas = 0
var user_id : String = ""
var user_key : String = ""
var pin : String = ""
var primeiro = false
var tempo_final : Timer
var lista = []
var status=true
var transition: Transition
var time_label: Label

# Agrupamento das cenas para usar e não precisar mudar em todo o projeto caso haja mudança do path
const LOGIN_SCREEN_SCENE = "res://scenes/login_screen/login_screen_scene.tscn"
const REGISTER_SCREEN_SCENE = "res://scenes/register_screen/register_screen_scene.tscn"
const FINAL_CREDITS_SCENE = "res://scenes/final_credits/final_credits.tscn"
const EXERCISE_TIME_SCENE  = "res://scenes/exercise_time/exercise_time_scene.tscn"
const SET_TIMER_FIRST_ACCESS_SCENE = "res://scenes/set_timer_first_access/set_timer_first_access_scene.tscn"
const MAIN_GAME_SCENE = "res://scenes/mundo_01.tscn"
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	tempo_final = Timer.new()
	#tempo_final.wait_time = 300
	tempo_final.wait_time = 60
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
	var saveUserDataUrl = "https://fit-farm-db-default-rtdb.firebaseio.com/usuarios/" + user_id + "/" + user_key + ".json"
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
		"primeiro": false,
		"status": status,
		"tempo_restante": tempo_final.wait_time,
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
	att_db()
	transition.change_scene(Global.EXERCISE_TIME_SCENE)
	
	
func setTransition(t: Transition):
	self.transition = t


func atualizar_tempo_transicao(tempo):
	tempo_final.wait_time = tempo


func setLabelTime():
	if Global.tempo_final.time_left <= 150:	
		self.time_label.visible=true
		self.time_label.text = "Tempo Restante: %02d : %02d" % [(int(Global.tempo_final.time_left/60)), (int(fmod(Global.tempo_final.time_left, 60)))]

	Global.tempo_final.wait_time = Global.tempo_final.time_left	
