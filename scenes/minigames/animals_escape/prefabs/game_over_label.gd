extends Control

var transition = null
@onready var pontos = %pontos
@onready var cristais = %cristais

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_retry_pressed():
	get_tree().reload_current_scene()
	
func setTransition(t: Transition):
	transition = t

func _on_exit_pressed():
	transition.animation.play("fade_in")
	await(transition.animation.animation_finished)
	SceneGameManager.change_scene_by_name("MAIN_GAME_SCENE")

