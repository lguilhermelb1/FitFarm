extends Node2D

@onready var game_fail := $game_fail as AudioStreamPlayer
@onready var player = $player_fuga_bichinhos
@onready var transition = $CanvasLayer/transition
@onready var cronometro = $CanvasLayer/Cronometro
@onready var pontuacao = $CanvasLayer/pontuacao


func _ready():	
	get_tree().paused = false
	Global.setTransition(transition)	
	cronometro.get_node("game_over_label").setTransition(transition)
	cronometro.get_node("Comfirm_Exit").setTransition(transition)	
	cronometro.get_node("Comfirm_Exit").setPlayer(player)
	cronometro.get_node("Comfirm_Exit").visible=false
	_create_time_label()


func _on_player_fuga_bichinhos_earn_points(scores, moedas):
	cronometro.set_scores(scores, moedas)
	pontuacao.text = "%08d" % scores
	

func _create_time_label():
	var viewport_size : Vector2 = get_viewport_rect().size
	if Global.time_label == null:
		Global.createTimeLabel()
	Global.tempo_final.start()
	Global.time_label.scale = Vector2(1.3, 1.3)
	var x = viewport_size.x - 260 - 20
	Global.time_label.position = Vector2(x, 30)
	Global.setLabelTime()		
	$CanvasLayer.add_child(Global.time_label)
