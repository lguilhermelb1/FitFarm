extends Node2D
class_name global_variables

# Pegar da base de dados
var cristais = 90
var moedas = 0
var user_id : String = ""
var user_key : String = ""
var pin : String = "397790"
var tempo_final: Timer
var lista = []
	
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
