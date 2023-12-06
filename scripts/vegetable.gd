extends Node2D
class_name vegetable_item

var _status = "fade_in"
var _current_time = 7
@onready var time = $timer

func _ready():
	print(time)
	
	
func get_status():
	return self._status

func set_status(st: String):
	self._status = st
	_change_type()
	
func get_timer() -> Timer:
	return time

func set_current_timer(t):
	await(self.ready)	
	_current_time = t
	time.wait_time = _current_time
	print("Novo_Wait_Time: ", time.wait_time)

func play_animation():
	$anim.play(self._status)
	await($anim.is_playing())
	time.wait_time = _current_time
	time.start()


func _change_type():
	await(self.ready)
	print(self._status)
	if self._status == "fade_in":
		$main_image.vframes=3
		$main_image.frame=2
		$main_image.modulate.a=1
		time.start()
		
	elif self._status == "second_percent":
		$main_image.vframes=2
		$main_image.frame=1
		$main_image.modulate.a=1
		print("WT_SP: ", time.wait_time)
		time.start()
								
	elif self._status == "final_percent":
		$main_image.vframes=1
		$main_image.frame=1
		$main_image.modulate.a=1
		time.stop()


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
		time.stop()

func _on_timer_timeout():
	time.stop()
	_current_time = 7
	time.wait_time = _current_time
	change_animation(self._status)
