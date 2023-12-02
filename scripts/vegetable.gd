extends Node2D
class_name vegetable_item

@onready var anim := $anim as AnimationPlayer
var _next_animation = ""

func start():
	anim.play("fade_in")
	$timer.wait_time = 5
	$timer.start()

func _on_anim_animation_finished(anim_name):
	if anim_name == "fade_in":
		_next_animation = "second_percent"		
	elif anim_name == "second_percent":
		_next_animation = "final_percent"	
	else:
		_next_animation = ""

func _on_timer_timeout():
	if (_next_animation == "second_percent" or _next_animation 
	== "final_percent") and anim.is_playing() == false:
		anim.play(_next_animation)
		$timer.wait_time = 5
		$timer.start()
	else:
		$timer.stop()
