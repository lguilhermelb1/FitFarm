extends Node

const PATHS = {
	"LOGIN_SCREEN_SCENE": "res://scenes/login_screen/login_screen_scene.tscn",
	"REGISTER_SCREEN_SCENE" : "res://scenes/register_screen/register_screen_scene.tscn",
	"FINAL_CREDITS_SCENE": "res://scenes/final_credits/final_credits.tscn",
	"EXERCISE_TIME_SCENE"  : "res://scenes/exercise_time/exercise_time_scene.tscn",
	"SET_TIMER_FIRST_ACCESS_SCENE" :"res://scenes/set_timer_first_access/set_timer_first_access_scene.tscn",
	"MAIN_GAME_SCENE" : "res://scenes/main/mundo_01.tscn",
 	#Minigames
	"MINIGAME_ANIMALS_SCAPE_SCENE" :"res://scenes/minigames/animals_escape/animals_escape_scene.tscn",
	"MINIGAME_BUG_INVADERS_SCENE":"res://scenes/minigames/bug_invaders/bug_invaders_scene.tscn"
}


func change_scene_by_path(scene_path: String) -> Error:
	var next_scene = load(scene_path)
	var scene_name : String = PATHS.find_key(scene_path)
	if next_scene:
		OrientationGameManager.update_orientation(scene_name)
		var result = get_tree().change_scene_to_packed(next_scene)
		return result
	else:
		return ERR_FILE_NOT_FOUND

func change_scene_by_name(name : String) -> Error:
	var path = PATHS.get(name)
	var next_scene = load(path)
	if next_scene:
		OrientationGameManager.update_orientation(name)
		var result = get_tree().change_scene_to_packed(next_scene)
		return result
	else:
		return ERR_FILE_NOT_FOUND

