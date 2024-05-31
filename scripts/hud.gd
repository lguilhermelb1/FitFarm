extends Control

@onready var score = $Score:
	set(value):
		score.text = "SCORE: " + str(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
