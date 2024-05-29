extends Node2D

var transition : Transition = null
var player = null

func _ready():
	visible = true
	process_mode = Node.PROCESS_MODE_ALWAYS

func setTransition(t: Transition):
	transition = t
	
func setPlayer(p: Node2D):
	player = p

func _on_yes_button_pressed():
	player.progresso_perdido()
	transition.change_scene(Global.MAIN_GAME_SCENE)

func _on_no_button_pressed():
	visible=false
	print("VV")
	get_tree().paused=false
