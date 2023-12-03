extends Node2D

@onready var camera := $camera as Camera2D
@onready var game_fail := $game_fail as AudioStreamPlayer
@onready var player = $player_fuga_bichinhos
@onready var transition = $camera/transition
@onready var cronometro = $player_fuga_bichinhos/Cronometro
@onready var game_over_label = $player_fuga_bichinhos/Cronometro/game_over_label


func _ready():	
	get_tree().paused = false
	get_window().size = Vector2(640, 320)
		
	game_over_label.set_transition(transition)
	cronometro.setTransition(transition)
	player.follow_camera(camera) 

	
func _on_insercao_body_entered(body):
	if body.is_in_group("animal"):
		player.ganhar_pontos()
		body.queue_free()

func _on_remocao_body_entered(body):
	if body.is_in_group("animal"):
		body.queue_free()
		game_fail.play()
