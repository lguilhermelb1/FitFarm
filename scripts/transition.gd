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
	_update_values()
	animation.play("fade_in")
	await(animation.animation_finished)
	assert(get_tree().change_scene_to_file(path) == OK)

func _update_values():
	if get_tree().current_scene.name == "Mundo01":
		for x in Global.lista:
			for v in get_tree().get_nodes_in_group("vegetable"):
				if v.global_position == x['position']:
					x['current_time'] = v.get_node("timer").time_left	
					x['status'] = v.get_status()
					print("TRANSITION: ", x['current_time'], "/", x['status'], "/", v.get_status())
	
