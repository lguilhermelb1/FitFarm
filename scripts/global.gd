extends Node2D
class_name global_variables

# Pegar da base de dados
<<<<<<< HEAD
var cristais = 900
var moedas = 9000
var user_id = ""
var pin = ""
=======
var cristais = 0
var moedas = 0
var user_id : String = ""
var pin : String = ""
>>>>>>> 4252e8916551417da0979f47b109def98f9caf2b
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
