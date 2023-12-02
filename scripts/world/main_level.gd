extends Node2D

@onready var camera := $camera as Camera2D
@onready var player := $player_world as Main_Player
@onready var inv = $camera/Inventory


# 640 x 320
func _ready():	
	$camera/Inventory/ScrollContainer/GridContainer.main_update()
	inv.visible = false

	get_window().size = Vector2(640, 320)
	player.position = Vector2(330,200)
	
	player.follow_camera(camera) 
	update_values()


func _on_button_label_inventory_pressed():
	if (get_tree().get_root().get_node("Dialog_Node") == null):
		inv.visible = true

func update_values():
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
