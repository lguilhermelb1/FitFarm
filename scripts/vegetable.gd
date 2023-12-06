extends Node2D
class_name vegetable_item

var _status = "fade_in"
var _current_time = 10
var time: Timer = null


func _ready():
	time = $timer
	print(time, ";", $timer)
		

func get_status():
	return self._status

func set_status(st: String):
	self._status = st
	_change_type()
	
func get_timer() -> Timer:
	return time

func set_current_timer(t):
	_current_time = t
	print(_current_time)


func play_animation():
	$anim.play(self._status)
	await($anim.is_playing())
	$timer.wait_time = _current_time
	$timer.start()


func _change_type():
	if self._status == "fade_in":
		$main_image.vframes=3
		$main_image.frame=2
		$main_image.modulate.a=1
			
	elif self._status == "second_part":
		$main_image.vframes=2
		$main_image.frame=1
		$main_image.modulate.a=1
						
	elif self._status == "final_percent":
		$main_image.vframes=1
		$main_image.frame=1
		$main_image.modulate.a=1


func change_animation(animation_name):
	if animation_name == "fade_in":
		self._status = "second_percent"
		play_animation()
	elif animation_name == "second_percent":
		self._status = "final_percent"	
		play_animation()
	else:
		self._status = "final_percent"
		$main_image.vframes=1
		$main_image.frame=1
		$main_image.modulate.a=1


func _on_timer_timeout():
	print("TIME_LEFT: ", $timer.time_left, "/", $timer.is_stopped())
	print(self._status)
	change_animation(self._status)
