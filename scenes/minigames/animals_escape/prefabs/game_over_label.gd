extends Node2D

var transition = null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_retry_pressed():
	get_tree().reload_current_scene()
	
func setTransition(t: Transition):
	transition = t

func _on_exit_pressed():
	print(transition)
	SceneGameManager.change_scene_by_name("MAIN_GAME_SCENE")

