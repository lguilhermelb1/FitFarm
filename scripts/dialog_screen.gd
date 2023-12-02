extends Node2D
class_name DialogueCreation

var data: Dictionary = {
	0: {
		"name"="Faz tudo",
		"dialog"="Olá, bem vindo ao Fit Farm"
	},
	
	1: {
		"name": "Faz tudo",
		"dialog": "Resolva algumas coisas"
	},
	
	2: {
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
