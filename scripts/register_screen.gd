extends Control

var webApiKey = "AIzaSyCpyA9AMffZszLkUhiKPq7VoMFEq-syef4"
var signUpUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="

func _signUp(url: String, email: String, password: String, pin: String):
	var http = $HTTPRequest
	var jsonObject = JSON.new()
	var body = jsonObject.stringify({'email' : email, 'password' : password})
	var headers = ['Content-Type: application/json']
	var error = await http.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	
	# Tratamento do request
	if response_code == 200:
		# Registro bem-sucedido, agora salve os dados no banco de dados
		var user_id = response.localId
		var pin = $PIN.text
		
		save_user_data(user_id, pin)
		
		get_tree().change_scene_to_file("res://scenes/mundo_01.tscn")
	else:
		print(response.error.message)
		if response.error.message == "INVALID_EMAIL":
			$UsernameErrorMessage.text = "E-mail inválido."
		elif response.error.message == "EMAIL_EXISTS":
			$UsernameErrorMessage.text = "E-mail já existente."
		elif response.error.message == "MISSING_PASSWORD":
			$PasswordErrorMessage.text = "Senha inválida."
		elif response.error.message == "INVALID_LOGIN_CREDENTIALS":
			$UsernameErrorMessage.text = "Credenciais incorretas."

func save_user_data(user_id, pin):
	var saveUserDataUrl = "https://db-nutricamp-default-rtdb.firebaseio.com/usuarios/" + user_id + ".json"
	var url = saveUserDataUrl
	
	# Dados iniciais do usuário
	var jsonObject = JSON.new()
	var initial_data = jsonObject.stringify({
		"pin": pin,
		"moedas": 100,  # Valor inicial para moedas (ajuste conforme necessário)
		"cristais": 50  # Valor inicial para cristais (ajuste conforme necessário)
	})

	# Solicitação para salvar dados no Realtime Database
	var request = HTTPRequest.new()
	add_child(request)

	var headers = ['Content-Type: application/json']
	request.request_completed.connect(_on_request_save_user_data_completed)
	request.request(url, headers, HTTPClient.METHOD_POST, initial_data)

# Função chamada quando a solicitação de salvar dados do usuário é concluída
func _on_request_save_user_data_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Dados do usuário salvos com sucesso!")
	else:
		print("Falha ao salvar dados do usuário:", response_code)

func _on_create_pressed():
	var url = signUpUrl + webApiKey
	var email = $Username.text
	var password = $Password.text
	var confirmPassword = $ConfirmPassword.text
	var pin = $PIN.text
	
	if email != "" and password.length() >= 6 and pin.length() >= 6:
		$PasswordErrorMessage.text = ""
		$PasswordErrorMessage.text = ""
		$PINErrorMessage.text = ""
	if confirmPassword == password:
		$ConfirmPasswordErrorMessage.text = ""
	
	if email != "" and password.length() >= 6 and confirmPassword == password and pin.length() >= 6:
		_signUp(url, email, password, pin)
	if email == "":
		$UsernameErrorMessage.text = "E-mail inválido."
	if password.length() < 6:
		$PasswordErrorMessage.text = "A senha deve conter 6 ou mais caracteres."
	if confirmPassword != password:
		$ConfirmPasswordErrorMessage.text = "Senha diferente."
	if pin == "" or pin.length() < 6:
		$PINErrorMessage.text = "O tamanho do PIN deve ser maior ou igual a 6."
