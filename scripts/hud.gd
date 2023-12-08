extends Control

@onready var score = $Score:
	set(value):
		score.text = "SCORE: " + str(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func atualizar_time(text_label):
	if Global.tempo_final != null:
		text_label.text = "Tempo Restante: %02d : %02d" % \
		[(int(Global.tempo_final.time_left/60)), (int(fmod(Global.tempo_final.time_left, 60)))]
		Global.tempo_final.wait_time = Global.tempo_final.time_left


