extends CharacterBody2D

var _dialog_screen: DialogueCreation


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		_dialog_screen =  load("res://prefab/dialog_node.tscn").instantiate()
		
		_dialog_screen.transform.origin[0] = transform.origin[0] - 56
		_dialog_screen.transform.origin[1] = transform.origin[1] - 70
		get_tree().get_root().add_child(_dialog_screen)
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		if _dialog_screen != null:
			_dialog_screen.queue_free()
			
