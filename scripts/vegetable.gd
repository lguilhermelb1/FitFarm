extends Node2D
class_name vegetable_item

var _status = "fade_in"


func get_status():
	return self._status
	

#func set_status(st: String):
#	print("Novo_Status: ", st)
	#print("Vframes: ", $main_image.vframes, "/Frames: ",
	#$main_image.frame, "/ Modulate ", $main_image.modulate.a)
	##self._status = st
	#_change_type()


func play_animation():
	if self._status != " ":
		$anim.play(self._status)
		print($anim.is_playing())
		await($anim.is_playing())
		change_animation(self._status)


func _change_type():
	if self._status == "fade_in":
		$main_image.vframes=3
		$main_image.frame=2
		$main_image.modulate.a=1
	elif self._status == "second_part":
		$main_image.vframes=2
		$main_image.frame=1
		$main_image.modulate.a=1
	elif self._status == "final_percent" or self._status == " ":
		$main_image.vframes=1
		$main_image.frame=1
		$main_image.modulate.a=1
		


func get_timer():
	return $timer

func set_timer(t):
	$timer.wait_time = t


func change_animation(animation_name):
	if animation_name == "fade_in":
		self._status = "second_percent"
		play_animation()
		$timer.wait_time = 10
		$timer.start()
	elif animation_name == "second_percent":
		self._status = "final_percent"	
		play_animation()
		$timer.wait_time = 10
		$timer.start()
	else:
		self._status = " "


func _on_timer_timeout():
	change_animation(self._status)

