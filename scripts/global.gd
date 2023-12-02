extends Node2D
class_name global_variables

# Pegar da base de dados
var cristais = 0
var moedas = 0
var user_id : String = ""
var pin : String = ""
var tempo_final: Timer


func set_user_id(id):
	user_id = id

func set_pin(user_pin):
	pin = user_pin
	
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
