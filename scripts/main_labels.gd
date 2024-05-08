extends Control

var inventory = null


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_button_label_pause_pressed():
	Global.att_db()
	if get_tree().paused == false:
		Global.tempo_final.stop()
		get_tree().paused=true
	else:
		Global.tempo_final.start()
		get_tree().paused=false
