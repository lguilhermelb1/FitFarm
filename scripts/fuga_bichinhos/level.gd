extends Node2D

@onready var camera := $camera as Camera2D
@onready var game_fail := $game_fail as AudioStreamPlayer
@onready var player = $player_fuga_bichinhos
@onready var transition = $camera/transition
@onready var cronometro = $player_fuga_bichinhos/Cronometro


func _ready():	
	get_tree().paused = false
	get_window().size = Vector2(640, 320)
	
	
	
	cronometro.get_node("game_over_label").setTransition(transition)
	cronometro.get_node("Comfirm_Exit").setTransition(transition)	
	cronometro.get_node("Comfirm_Exit").setPlayer(player)
	cronometro.get_node("Comfirm_Exit").visible=false
	
	if Global.tempo_final != null:
		$camera/time_control/label_time.text = "Tempo Restante: %02d : %02d" % \
		[(int(Global.tempo_final.time_left/60)), (int(fmod(Global.time_left, 60)))]
	player.follow_camera(camera) 


func _process(delta):
	if Global.tempo_final != null:
		$camera/time_control/label_time.text = "Tempo Restante: %02d : %02d" % \
		[(int(Global.tempo_final.time_left/60)), (int(fmod(Global.time_left, 60)))]


func _on_insercao_body_entered(body):
	if body.is_in_group("animal"):
		player.ganhar_pontos()
		body.queue_free()

func _on_remocao_body_entered(body):
	if body.is_in_group("animal"):
		body.queue_free()
		game_fail.play()
