extends Node2D

@onready var transition_animation := $transition/animation

# Called when the node enters the scene tree for the first time.
func _ready():
	await(transition_animation.is_playing())
	$animation.play("opening")
	await($animation.is_playing() == false)
	await(get_tree().create_timer(10).timeout)
	$animation.play("criacao_pin")
	$Control/PIN.visible=true
	$Control/Tempo.visible=true
	$Control/Button.visible = true

func _on_button_pressed():
	if Global.pin == $Control/PIN.text and $Control/Tempo.text != " ":
		
		Global.tempo_final.wait_time = int($Control/Tempo.text) * 60
		$transition.change_scene("res://scenes/mundo_01.tscn")
		print("V")
	else:
		print("F")
