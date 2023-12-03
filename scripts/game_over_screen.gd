extends Control

var transition: Transition = null
@onready var anim = $anim

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func setTransition(t: Transition):
	transition = t


func _on_retry_pressed():
	print("V")
	get_tree().reload_current_scene()

func set_score(score):
	$Panel/Score.text = "PONTUAÇÃO: " + str(score)
	
func set_high_score(score):
	$Panel/HighScore.text = "MAIOR PONTUAÇÃO: " + str(score)

func play_animation_apperence():
	anim.play("show_label")

func _on_exit_pressed():
	print("F")	
	transition.change_scene("res://scenes/mundo_01.tscn")
	#await(anim.animation_finished)
	#get_tree().change_scene_to_file("res://scenes/mundo_01.tscn")
