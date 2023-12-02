extends Control
class_name Transition

@onready var animation := $animation as AnimationPlayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	animation.play("fade_out")
	await(animation.animation_finished)
		
	
func change_scene(path: String):
	get_tree().paused = true
	animation.play("fade_in")
	await(animation.animation_finished)
	assert(get_tree().change_scene_to_file(path) == OK)
