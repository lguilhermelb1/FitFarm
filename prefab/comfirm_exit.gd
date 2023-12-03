extends Node2D

var transition : Transition = null
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func setTransition(t: Transition):
	transition = t
	
func setPlayer(p: Node2D):
	player = p

func _on_yes_button_pressed():
	player.progresso_perdido()
	transition.change_scene("res://scenes/mundo_01.tscn")

func _on_no_button_pressed():
	visible=false
	get_tree().paused=false
	
