extends Node2D

@onready var camera := $camera as Camera2D
@onready var game_fail := $game_fail as AudioStreamPlayer
@onready var player = $player_fuga_bichinhos
@onready var transition = $camera/transition
@onready var cronometro = $player_fuga_bichinhos/Cronometro


func _ready():	
	get_tree().paused = false
	print("NOVO_TEMPO: ", Global.tempo_final.wait_time)

	Global.setTransition(transition)
		
	cronometro.get_node("game_over_label").setTransition(transition)
	cronometro.get_node("Comfirm_Exit").setTransition(transition)	
	cronometro.get_node("Comfirm_Exit").setPlayer(player)
	cronometro.get_node("Comfirm_Exit").visible=false
	
	if Global.time_label == null:
		Global.createTimeLabel()
	

	Global.time_label.position = Vector2(155,55)
	Global.time_label.scale = Vector2(.5, .5)
	Global.tempo_final.start()
	print(Global.time_label)
	
	$camera/time_control.add_child(Global.time_label)
	Global.tempo_final.start()	
	print(Global.time_label.text)

	print("Started")
	player.follow_camera(camera) 
