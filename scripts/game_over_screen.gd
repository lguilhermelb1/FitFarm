extends Control

var transition: Transition = null
@onready var anim = $anim
@onready var coin_label = %CoinLabel
@onready var score_label = %ScoreLabel


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func setTransition(t: Transition):
	transition = t


func _on_retry_pressed():
	get_tree().reload_current_scene()

func set_score(score):
	score_label.text = "PONTUAÇÃO: " + str(score)
	
func set_high_score(score):
	coin_label.text = "Moedas: " + str(score)

func play_animation_apperence():
	anim.play("show_label")

func _on_exit_pressed():
	transition.change_scene(SceneGameManager.PATHS.MAIN_GAME_SCENE)
