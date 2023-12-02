extends Control

var webApiKey = "AIzaSyCpyA9AMffZszLkUhiKPq7VoMFEq-syef4"
var loginUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="
var Global = preload("res://scripts/global.gd")

# Função login e sign up
func _login(url: String, email: String, password: String):
	var http = $HTTPRequest
	var jsonObject = JSON.new()
	var body = jsonObject.stringify({'email' : email, 'password' : password})
	var headers = ['Content-Type: application/json']
	var error = await http.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	
	if response_code == 200:
		var user_id = response.localId
		
		# Agora você pode usar o user_id para recuperar dados específicos do usuário no Firebase
		
		# Construa o URL para recuperar dados do usuário
		var url = "https://db-nutricamp-default-rtdb.firebaseio.com/usuarios/" + user_id + ".json"
		
		# Crie uma instância de HTTPRequest
		var request = HTTPRequest.new()
		add_child(request)
		
		# Configure a solicitação para recuperar dados do Firebase
		request.request(url)
		
		# Use uma função anônima para encapsular a chamada à sua função
		var request_callback = func(result, response_code, headers, body):
			_on_request_user_data_completed(result, response_code, headers, body)
		
		# Conecte a função anônima ao sinal
		request.connect("request_completed", request_callback)
	else:
		handle_login_error(response.error.message)

func _on_request_user_data_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Dados do usuário salvos com sucesso!")
		var user_data = JSON.parse_string(body.get_string_from_utf8())
		
		# Atualize as variáveis globais com os dados do usuário
		Global.user_id = user_data.user_id
		Global.pin = user_data.pin
		Global.moedas = user_data.moedas
		Global.cristais = user_data.cristais
		
		# Agora você pode acessar essas variáveis globais em qualquer lugar do seu projeto
		
		get_tree().change_scene_to_file("res://scenes/mundo_01.tscn")
	else:
		handle_data_error(response_code)
		print("Falha ao salvar dados do usuário:", response_code)

func handle_login_error(error_message: String) -> void:
	print(error_message)
	if error_message == "INVALID_EMAIL":
		$UsernameErrorMessage.text = "E-mail inválido."
	elif error_message == "MISSING_PASSWORD":
		$PasswordErrorMessage.text = "Senha inválida."
	elif error_message == "INVALID_LOGIN_CREDENTIALS":
		$UsernameErrorMessage.text = "Credenciais incorretas."
	else:
		# Lidar com outros erros, se necessário
		pass

func handle_data_error(response_code: int) -> void:
	print("Falha ao recuperar dados do usuário:", response_code)
	# Lidar com erros de dados, se necessário
	# Exemplo: exibir uma mensagem de erro ou realizar outras ações apropriadas

func _on_create_pressed():
	get_tree().change_scene_to_file("res://scenes/register_screen.tscn")

func _on_login_pressed():
	var url = loginUrl + webApiKey
	var email = $Username.text
	var password = $Password.text
	_login(url, email, password)
