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
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	
	print(Global.tempo_final)
	
	#$camera/Control/label_tempo_final.text = "%02d : %02d" % [int(Global.tempo_final.time_left/60), 
	#											int(fmod(Global.tempo_final.time_left, 60))]
	player.follow_camera(camera) 
	
	atualizar()
	update_values()


func _on_button_label_inventory_pressed():
	if (get_tree().get_root().get_node("Dialog_Node") == null):
		inv.visible = true


func update_values():
	$camera/Control/label_cristais.text = "%08d" % Global.cristais
	$camera/Control/label_moedas.text = "%08d" % Global.moedas
	

func atualizar():
	#[<Freed Object>, (573.5, 76)]
	
	for x in Global.lista:
		if x != null:
			print(x)
			#x[0] = x[0].instantiate()
			#get_tree().get_root().add_child(x[0])
			

func _process(delta):
	atualizar()

