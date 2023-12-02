extends Node2D
class_name global_variables

# Pegar da base de dados
var cristais = 300
var moedas = 300
var user_id = ""
var pin = ""
var tempo_final: Timer


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
