extends Node2D

@onready var transition_animation := $transition/animation

# Called when the node enters the scene tree for the first time.
func _ready():
	get_window().size = Vector2(640, 320)
	await(transition_animation.is_playing())
	
	$animation.play("opening")
	$Control/PIN.editable=false
	$Control/Tempo.editable=false
	$Control/Button.disabled=true
	
	$Control/Error_message.visible=false
	$Control/Error_message.text=""
	$Control/Error_Time_Message.visible=false
	$Control/Error_Time_Message.text=""
	
	await($animation.is_playing() == false)
	
	if name == 'Scene_SetTime':
		await(get_tree().create_timer(3).timeout)
	else:
		await(get_tree().create_timer(5).timeout)
	
	$animation.play("criacao_pin")
	await($animation.is_playing())
	$Control/PIN.editable=true
	$Control/Tempo.editable=true
	$Control/Button.disabled=false


func _on_button_pressed():
	
	if Global.pin != $Control/PIN.text:
		$Control/Error_message.text = "PIN INVÁLIDO, INSIRA NOVAMENTE"
		$Control/Error_message.visible=true
		await(get_tree().create_timer(3).timeout)
		$Control/Error_message.visible=false
	
	if $Control/Tempo.text == "":
		$Control/Error_Time_Message.text = "TEMPO LIMITE INVÁLIDO, INSIRA NOVAMENTE"
		$Control/Error_Time_Message.visible=true
		await(get_tree().create_timer(3).timeout)
		$Control/Error_Time_Message.visible=false
		
	elif int($Control/Tempo.text) < 20 or int($Control/Tempo.text) > 120 and $Control/Tempo.editable == true:
		$Control/Error_Time_Message.text = "O TEMPO LIMITE DEVE SER ENTRE 20 e 120 minutos"
		$Control/Error_Time_Message.visible=true
		await(get_tree().create_timer(3).timeout)
		$Control/Error_Time_Message.visible=false
		
	if Global.pin == $Control/PIN.text and $Control/Tempo.text != "" \
	and int($Control/Tempo.text) >= 20 and int($Control/Tempo.text) <= 120:
		Global.atualizar_tempo_transicao(int($Control/Tempo.text)*60)
		Global.setTransition($transition)
		$transition.change_scene("res://scenes/lista_exercicios.tscn")
