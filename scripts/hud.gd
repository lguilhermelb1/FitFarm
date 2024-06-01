extends Control

signal exit_button_pressed

@onready var exit_button = $ExitButton

@onready var score = $Score:
	set(value):
		score.text = "SCORE: " + str(value)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS



func _on_exit_button_pressed():
	exit_button_pressed.emit()
