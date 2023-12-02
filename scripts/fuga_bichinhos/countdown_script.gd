extends Node2D
class_name cronometro

@onready var countdown := $countdown as Label
@onready var timer := $timer as Timer
@onready var anim := $anim as AnimationPlayer
@onready var game_over_label := $game_over_label as Node2D
@onready var cristais := $game_over_label/Panel/cristais as Label
@onready var pontos := $game_over_label/Panel/pontos as Label
@onready var timeout := $timeout as AudioStreamPlayer

var transition  = null

func _ready():
	game_over_label.visible = false
	timer.wait_time = 5
	timer.start()

func _process(delta):
	countdown.text = format_seconds(timer.time_left)

func format_seconds(t: float) -> String:
	return "%02d : %02d" % [(int(t/60)), (int(fmod(t, 60)))]

func _on_timer_timeout():
	timer.stop()	
	timeout.play()
	game_over_label.visible = true
	anim.play("game_over_anim")
	
func set_scores(s: int):
	cristais.text = "Cristais: %08d" % Global.cristais
	pontos.text = "Pontuação: %08d" % s 

func setTransition(t: Transition):
	transition = t

func _on_exit_button_pressed():
	transition.change_scene("res://scenes/mundo_01.tscn")

func _on_anim_animation_finished(anim_name):
	if anim_name == 'game_over_anim':
		get_tree().paused=true
