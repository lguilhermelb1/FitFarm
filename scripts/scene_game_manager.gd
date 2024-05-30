extends Node
signal scene_changed

func change_scene(scene_path: String) -> Error:
	print(scene_path)
	var next_scene = load(scene_path)
	if next_scene:
		var result = get_tree().change_scene_to_packed(next_scene)
		scene_changed.emit()
		return result
	else:
		return ERR_FILE_NOT_FOUND



