extends Node2D
class_name DialogueCreation

var data: Dictionary = {
	0: {
		"name"="Faz tudo",
		"dialog"="Olá, bem vindo ao Fit Farm. O jogo irá lhe ajudar a equilibrar o tempo de jogo com o tempo de atividade física"
	},
	
	1: {
		"name": "Faz tudo",
		"dialog": "Eu preciso que você compre alguns recursos para melhorar a fazenda"
	},

	2: {
		"name": "Faz tudo",
		"dialog": "Irei dar a você algumas moedas para começar.Jogue nos minigames para conseguir cristais e desbloquear novos recursos"
	},
	
	3: {
		"name": "Faz tudo",
		"dialog": "Tenha um bom dia"
	}
}

var _id = 0
var _steps = 0.05
@onready var _character_name := $Dialog_Control/character_name as Label
@onready var _dialog  := $Dialog_Control/dialog as RichTextLabel


func _ready():
	create_dialog()

func get_id():
	return _id
	
func set_id():
	return _id


func _process(delta):
	
	if Input.is_action_pressed("ui_next") and _dialog.visible_ratio < 1:
		_steps = 0.01
		return
		
	_steps = 0.05
	
	if Input.is_action_just_pressed("ui_next"):
		_id += 1
		if _id == len(data):
			give_coins()
			queue_free()
			return
		create_dialog()


func create_dialog():
	_character_name.text = data[_id]['name']
	_dialog.text = data[_id]['dialog']
	_dialog.visible_characters = 0
	
	while(_dialog.visible_ratio < 1):
		await get_tree().create_timer(_steps).timeout
		_dialog.visible_characters += 1


func give_coins():
	Global.status=false
	Global.moedas += 30
	Global.att_db()
	get_tree().get_root().get_child(3).get_node("HUD").update_values_resources()
	#get_tree().get_root().get_child(1).get_node("camera").get_node("Control")\
	#.get_node("label_moedas").text = "%08d" % Global.moedas
