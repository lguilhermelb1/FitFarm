extends Area2D

@onready var start_button := $start_button
@export var next_world = ""
@onready var transition = $"../camera/transition"
var _dentro_area = false
@onready var hud = %HUD


func _ready():
	start_button.visible = false

func _on_body_entered(body):
	start_button.visible = true
	if body.name == "player_world":
		_dentro_area = true

func _on_body_exited(body):
	start_button.visible = false
	_dentro_area = false

func _on_start_button_pressed():
	if _dentro_area == true and hud.inventory.visible == false:
		transition.change_scene(Global.get(next_world))
