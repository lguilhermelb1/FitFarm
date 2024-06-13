extends CanvasLayer
@onready var label_cristais = %LabelCristais
@onready var label_moedas = %LabelMoedas
@onready var button_pause = %ButtonPause
@onready var button_store = %ButtonStore
@onready var inventory = %Inventory


const CRISTAL_BB_CODE = "[img=30]res://assets/Objects/cristal.png[/img]"
const COIN_BB_CODE = "[img=40]res://assets/Objects/coin_icon.png[/img]"

# Carregando os ícones dos botões
var icon_play = preload("res://assets/Controls/play.png")
var icon_pause = preload("res://assets/Controls/pause.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.visible = false
	label_cristais.text = "%08d%s" % [Global.cristais, CRISTAL_BB_CODE]
	label_moedas.text = "%08d%s" % [Global.moedas, COIN_BB_CODE]
	if Global.time_label == null:
		Global.time_label = Label.new()	
	Global.time_label.position = Vector2(-60,-70)
	Global.time_label.scale = Vector2(.6, .6)
	self.add_child(Global.time_label)


func update_values_resources():
	label_cristais.text = "%08d%s" % [Global.cristais, CRISTAL_BB_CODE]
	label_moedas.text = "%08d%s" % [Global.moedas, COIN_BB_CODE]


	


func _on_button_store_pressed():
	button_store.disabled = true
	get_tree().paused = true
	inventory.visible = true



func _on_inventory_store_closed():
	inventory.visible = false
	button_store.disabled = false
	get_tree().paused = false
	

func _on_button_pause_pressed():
	if get_tree().paused:
		get_tree().paused = false
		button_pause.icon = icon_pause
		Global.tempo_final.paused = false
	else:
		get_tree().paused = true
		button_pause.icon = icon_play
		Global.tempo_final.paused = true
