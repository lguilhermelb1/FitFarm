extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	if Global.tempo_final != null:
		print("X")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
