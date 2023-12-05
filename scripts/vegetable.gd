extends Node2D
class_name vegetable_item

var _status = "fade_in"

func get_status():
	return self._status
	
func set_status(st: String):
	self._status = st
	
func play_animation():
	if self._status == "":
		$main_image.visible=true
	else:
		print("STATUS: ", self._status)
		$anim.play(self._status)
		$timer.wait_time = 10
		$timer.start()

func _on_anim_animation_finished(anim_name):
	if anim_name == "fade_in":
		self._status = "second_percent"		
	elif anim_name == "second_percent":
		self._status = "final_percent"	
	else:
		self._status = ""


func _on_timer_timeout():
	if (_status == "second_percent" or _status == "final_percent") and $anim.is_playing() == false:
		play_animation()
	else:
		$timer.stop()
