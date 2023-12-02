extends Control

var webApiKey = "AIzaSyCpyA9AMffZszLkUhiKPq7VoMFEq-syef4"
var loginUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="

#Função login e sign up
func _login(url: String, email: String, password: String):
	var http = $HTTPRequest
	var jsonObject = JSON.new()
	var body = jsonObject.stringify({'email' : email, 'password' : password})
	var headers = ['Content-Type: application/json']
	var error = await http.request(url, headers, HTTPClient.METHOD_POST, body)


func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	
	#Tratamento do request
	if (response_code == 200):
		get_tree().change_scene_to_file("res://scenes/mundo_01.tscn")
	else:
		print(response.error.message)
		if response.error.message == "INVALID_EMAIL":
			$UsernameErrorMessage.text = "E-mail inválido."
		elif response.error.message == "MISSING_PASSWORD":
			$PasswordErrorMessage.text = "Senha inválida."
		elif response.error.message == "INVALID_LOGIN_CREDENTIALS":
			$UsernameErrorMessage.text = "Credenciais incorretas."

func _on_create_pressed():
	get_tree().change_scene_to_file("res://scenes/register_screen.tscn")

func _on_login_pressed():
	var url = loginUrl + webApiKey
	var email = $Username.text
	var password = $Password.text
	_login(url, email, password)
