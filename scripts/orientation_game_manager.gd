extends Node

# DEFAULT é landscape
enum ScreenOrientation {
	LANDSCAPE,
	PORTRAIT,
	DEFAULT
}

var orientations_list = {
	"MINIGAME_ANIMALS_SCAPE_SCENE": ScreenOrientation.LANDSCAPE,
	"MINIGAME_BUG_INVADERS_SCENE": ScreenOrientation.PORTRAIT,
}

func _ready():
	if(get_tree().current_scene.get_path().get_concatenated_names() == SceneGameManager.PATHS.MAIN_GAME_SCENE):
		update_orientation(ScreenOrientation.DEFAULT)	 
	
	
func set_orientation(orientation):
	match orientation:
		ScreenOrientation.PORTRAIT:
			DisplayServer.screen_set_orientation(DisplayServer.SCREEN_PORTRAIT)	
		ScreenOrientation.LANDSCAPE:
			DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
		ScreenOrientation.DEFAULT:
			DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
		_:
			DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)

func update_orientation(scene_name):
		if scene_name in orientations_list:
			var orientation = orientations_list[scene_name]
			set_orientation(orientation)
		else:
			set_orientation(ScreenOrientation.DEFAULT)
		print("Orientation: %s" %DisplayServer.screen_get_orientation())


