extends Control

var inventory = null


# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = get_tree().get_root().get_children()[1].get_children()[3].get_children()[3]
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_label_pause_pressed():
	Global.att_db()
	if get_tree().paused == false:
		Global.tempo_final.stop()
		get_tree().paused=true
	else:
		Global.tempo_final.start()
		get_tree().paused=false


func _on_button_label_inventory_pressed():
	if (get_tree().get_root().get_node("Dialog_Node") == null):
		#$camera/Inventory.visible = true
		inventory.visible = true
