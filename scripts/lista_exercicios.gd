extends Control

var transition: Transition = null

func _on_play_button_pressed():
	print("entrou")
	#var tempo_em_minutos = int(get_node("../Control/Tempo").text)
	#print(tempo_em_minutos)
	#Global.atualizar_tempo_transicao(tempo_em_minutos * 60)
	transition.change_scene("res://scenes/mundo_01.tscn")
